# poem-analyzer
Very rudimentyary script for scanning the meter of English poetry:

## Process
0) takes as input a text file containing one poem
1) loads the Carnegie Mellon Uni pronunciation dictionary as JSON
2) tokenizes each line (removes punctuation, converts to lower case)
3) phoneticizes each word, if possible, according to the CMU dict
4) syllabizes the word based on stress markers (0-2)
5) scans the word based on syllabic stress
6) outputs conventional visual representation of meter
     _ => unstressed, ^ => stressed
     e.g. (iambic pentameter: ^_ ^_ ^_ ^_ ^_)

Unfortunately not particularly accurate at the moment!

Based on a poetry analysis tool written in python: https://github.com/warrengalyen/PoetryAnalysis
