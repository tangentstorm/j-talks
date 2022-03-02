
NB. `sudo apt install wamerican-large` to get the words
words  =: LF cut freads '/usr/share/dict/words'
a =: > words #~ 11 = # S:0 words
b =: > words #~ 4 = # S:0 words
c =: (I.~: 'mississippi'){"1 a
d =: (I. c e. b) { a,.' ',.c
'misp.txt' fwrites~ LF joinstring <"1 d
