# poem-analyzer    p lines[line_num]
Rather rudimentary script for scanning the meter of English poetry! Still has a lot of work to do.

## Example
```
❯ ruby poem-analysis.rb poems/whitman.txt
^ ^ _ ^     ^ ^     _   ^    ^ ^
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
At this initial stage, the analyzer is not particularly accurate. It doesn't handle words containing punctuation or variants very well. Nor is it good at guessing variation (e.g. in the Whitman example above, the CMU lookup returns 'loaf' but not 'loafe'). 

Next steps include integrating some basic metrical rules (such as unstressed monosyllables, especially verse-initial ones) and providing some sort of syllabic estimation for words that aren't found in the CMU at all, peraps based on word length. 

After that, it's onward to metrical feet and larger structures (rhymes, stanzas, etc).


Inspired by a poetry analysis tool written in python: https://github.com/warrengalyen/PoetryAnalysis
