# poem-analyzer
Very rudimentyary script for scanning the meter of English poetry!

## Example

## Approach
0) takes as input a text file containing one poem (with no title, author, or any other headers)
1) loads the Carnegie Mellon Uni pronunciation dictionary as JSON
2) tokenizes each line (removes punctuation, converts to lower case)
3) phoneticizes each word, if possible, according to the CMU dict
4) syllabizes the word based on stress markers (0-2)
5) scans the word based on syllabic stress
6) outputs conventional visual representation of meter
     _ => unstressed, ^ => stressed
     e.g. (iambic pentameter: ^_ ^_ ^_ ^_ ^_)

## To do
Unfortunately at this initial stage, the analyzer is not particularly accurate. Currently it does not handle words containing punctuation or variants very well. The next steps include integrating some basic metrical rules (such as unstressed monosyllables) and providing some sort of "guess" for words that aren't found in the CMU (perhaps based on word length).

After that, it's onward to metrical feet and larger structures (rhymes, stanzas, etc).


Inspired by a poetry analysis tool written in python: https://github.com/warrengalyen/PoetryAnalysis
