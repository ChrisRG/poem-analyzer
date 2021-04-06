# Poem Analyzer (name up for debate 🤔)
Rather rudimentary script for scanning the meter of English poetry! Still has a lot of work to do.

## Example
```
❯ ruby poem-analysis.rb poems/whitman.txt
^ ^ _ _     _ ^     _   ^    _ ^
I celebrate myself, and sing myself,
_   ^    ^ _ ^    ^   ^     _ ^
And what I assume you shall assume,
^   ^ _ _ ^ _  _ ^ _     ^  ^  ^  ^    _ ^     ^  ^
For every atom belonging to me as good belongs to you.
^ ^     _   _ ^    ^  ^
I loafe and invite my soul,
^ ^    _   ^     ^  ^  ^    _ ^ _     _ ^     ^  ^ _    ^
I lean and loafe at my ease observing a spear of summer grass.
```

## Setup
Make sure you have [Ruby](https://www.ruby-lang.org/en/documentation/installation/) installed. The script should work with all versions, although I used [rbenv](https://github.com/rbenv/rbenv#installation) to force Ruby version 2.6.6.

In your terminal, choose a directory to copy the program and next clone the repository:
```
git clone https://github.com/ChrisRG/poem-analyzer.git
```
Next change into the poem-analyzer directory and run the script and target a poem:
```
> cd poem-analyzer
> ruby poem-analysis.rb poems/whitman.txt
```
There are a few snippets of poems available in the poems/ directory, although any plain .txt file can be used.


## How it works
The script

0) takes as an argument a text file containing one poem (with no title, author, or any other headers)
1) loads into a hash [Carnegie Mellon University's pronunciation dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict/), stored locally as a JSON
2) tokenizes the words in each line by removing punctuation and converting everything to lower case

     ``` "I celebrate myself" => ["i", "celebrate", "myself"] ```
     
4) searches for each word in the CMU dictionary, which returns a standardized phonetic representation

     ``` "celebrate" => [["S", "EH1", "L", "AH0", "B", "R", "EY2", "T"]] ```
     
5) syllabizes the word based on the CMU dictionary's stress markers (0-2)

    ``` [["S", "EH1", "L", "AH0", "B", "R", "EY2", "T"]] => ["1", "0", "2"] ```
     
7) scans the word based on syllabic stress, where primary (1) stress is depicted with ```^``` and secondary (2) stress or unstressed (0) with ```_```

     ``` ["1", "0", "2"] => ["^", "_", "_"] ```
     
9) collects the scanned words and outputs a conventional visual representation of each line's meter

     ```
     ^ ^ _ _     _ ^  
     I celebrate myself
     ```
     

## To do
At this initial stage, the analyzer is not particularly accurate. It doesn't handle words containing punctuation or variants very well. Nor is it good at guessing variation (e.g. in the Whitman example above, the CMU lookup returns 'loaf' but not 'loafe'). 

Next steps include integrating some basic metrical rules (such as unstressed monosyllables, especially verse-initial ones) and providing some sort of syllabic estimation for words that aren't found in the CMU at all, peraps based on word length. 

After that, it's onward to metrical feet and larger structures (rhymes, stanzas, etc).


Inspired by a poetry analysis tool written in python: https://github.com/warrengalyen/PoetryAnalysis
