# Very rudimentyary script for scanning the meter of English poetry:
#
# 0) takes as input a text file containing one poem
# 1) loads the Carnegie Mellon Uni pronunciation dictionary as JSON
# 2) tokenizes each line (removes punctuation, converts to lower case)
# 3) phoneticizes each word, if possible, according to the CMU dict
# 4) syllabizes the word based on stress markers (0-2)
# 5) scans the word based on syllabic stress
# 6) outputs conventional visual representation of meter
#     _ => unstressed, ^ => stressed
#     e.g. (iambic pentameter: ^_ ^_ ^_ ^_ ^_)
#
# Unfortunately not particularly accurate at the moment!

require 'json'

# Load the Carnegie Mellon Pronunciation Dictionary
CMU = JSON.load(File.open('cmu-dict/cmudict.json'))

# Splits line into words and strips non-alphabetical characters
def tokenize(line)
  tokenized_line = line.split
  tokenized_line
    .map { |token| token.chomp.downcase.gsub(/\W/, '') }
    .reject(&:empty?)
end

# Searches word in CMU, outputs array of arrays of possible pronunciations
def phoneticize(word)
  phoneticized = CMU[word]
  # For now return first ('primary') variant or empty string if lookup fails
  return phoneticized[0] unless phoneticized.nil?

  [['']]
end

# Returns an array of stressed phonemes, i.e. syllables
def syllabize(word)
  # Returns an unstressed syllable if the CMU had failed
  # Need to fix!
  return ['0'] if word[0][0].empty?

  word.select { |phoneme| phoneme =~ /[0-2]/ }
end

# Returns a visual representation of stress
def scan(phoneme_array)
  phoneme_array.map { |phoneme| stressed?(phoneme) }
end

# Returns ^ if phoneme has primary or secondary stress, otherwise _
def stressed?(phoneme)
  phoneme =~ /[12]/ ? '^' : '_'
end

# Prints the scanned line using ^ (stressed) and _ (unstressed)
def print_meter(lines, scanned_lines)
  (0...lines.length).each do |i|
    p scanned_lines[i]
    puts lines[i]
  end
end

# TODO: For print_meter, for each line:
# create a scanned_string with spaces equal to the original line
# find the index and length of each word in line.split
# insert the scanned_word[index].joined at scanned_string[index]
# print scanned_line
# print line
# for the associated index in scanned_lines, use word.length to fill space

## --- File processing 

# Check for weird arguments when running the script
def check_args?
  if ARGV.length != 1
    puts 'Run the script with: > ruby poem-analysis.rb [poem].txt'
    exit
  elsif !File.file?(ARGV[0])
    puts 'File does not seem to exist!'
    exit
  else
    true
  end
end

# Loads the file
def load_poem(filename)
  File.readlines(filename, chomp: true).reject(&:empty?)
end

# Tokenize, phoneticize, syllabize, and scan each line
def analyze(lines)
  scanned_lines = []
  lines.each do |line|
    tokenized_line = tokenize(line)
    phoneticized_line = tokenized_line.map { |word| phoneticize(word) }
    syllabized_line = phoneticized_line.map { |word| syllabize(word) }
    scanned_line = syllabized_line.map { |syllables| scan(syllables) }
    scanned_lines << scanned_line
  end
  scanned_lines
end

# Run the script! Analyze the lines & print the poem with its meter.
lines = load_poem(ARGV[0]) if check_args?
scanned_lines = analyze(lines)
print_meter(lines, scanned_lines)
