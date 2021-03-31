# Simple syllabification and scansion script:
#
# 0) loads the Carnegie Mellon Uni pronunciation dictionary JSON
# 1) takes as input a text file containing one poem
# 2) tokenizes each line (i.e. removes punctuation, converts to lower case)
# 3) iterates through each word, searches for form in the CMU
# 4) based on pronunciation, generates the scansion for each line
#
# Inspired by a poetry analysis tool in python:
#   https://github.com/warrengalyen/PoetryAnalysis

# load CMU

require 'json'

CMU = 

# Tokenizing: splitting a line into words and stripping non-alphabetical characters
def tokenize(line)
  tokenized_line = line.split
  tokenized_line.map { |token| token.chomp.downcase.gsub(/\W/, '') }
end


# Main program
# Check for weird stuff when running the script
if ARGV.length != 1
  puts 'Run the script with: > ruby poem-analysis.rb [poem].txt'
  exit
end

filename = ARGV[0]
unless File.file?(filename)
  puts 'File does not seem to exist!'
  exit
end

# Save the file as an array of lines before tokenizing and scanning each line
# Scanned lines are saved into a new array and displayed
lines = File.readlines(filename)
lines.each do |line|
  p tokenize(line)
end
