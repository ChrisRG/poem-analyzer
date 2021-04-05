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

# Returns an array of word's stressed/unstressed phonemes (i.e. syllables)
def syllabize(word)
  # Currently returns a stressed syllable if the CMU lookup fails
  return ['0'] if word[0][0].empty?

  word.select { |phoneme| phoneme =~ /[0-2]/ }
end

# Returns an array of stress markers for the phonemes
def scan(phoneme_array)
  phoneme_array.map { |phoneme| stressed?(phoneme) }
end

# Returns ^ if phoneme has primary or secondary stress, otherwise _
def stressed?(phoneme)
  phoneme =~ /[12]/ ? '^' : '_'
end

# Iterates through lines, prints meter (^ / _) above the original line
def print_meter(lines, scanned_lines)
  (0...lines.length).each do |line_num|
    p scanned_line[line_num]
    p scanned_lines[line_num]
    # puts metrify_string(lines[line_num], scanned_lines[line_num])
    # puts lines[line_num]
  end
end

# Returns a string with stress markers indexed to words of original line
def metrify_string(line, scanned_line)
  # Creates a blank line the same size as the original
  meter_string = ' ' * line.length
  # Iterates through original tokenized words
  tokenize(line).each_with_index do |word, index|
    # Finds the position of the word as an index (nil if not found)
    word_position = line.downcase =~ /#{word.downcase}/
    next if word_position.nil?

    # Inserts meter array into blank line at same index as original word
    meter_string[word_position] = scanned_line[index].join(' ')
  end
  meter_string
end

# Checks for weird arguments when running the script
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

# Tokenizes, phoneticizes, syllabizes, and scans each line
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
