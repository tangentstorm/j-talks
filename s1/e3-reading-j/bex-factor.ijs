
NB. my problem generator for bex::solve::find_factors

xy0 =: */L:0 (0,"1#:i.2^n-1) </."1 |.p:i.n=:15
NB. |.p:i.n=:15 is the first 15 primes, in reverse order
NB. (x) </."1 y is separating y into boxes based on the keys in each row of x
NB. x here is just counting in binary to 2^n-1
NB.   (this gives us every possible way of separating the primes into 2 groups)
NB.   we use n-1 instead of n so we only get the first ordering.
NB.   but that's only n-1 bits, and we need n bits, so add leading 0
NB.   0,.y would have been shorter than 0,"1 y
NB. Now */L:0 is multiplying the items in each box.

xys =: ({~[:I.([:*./(2^32)>])"1) \:~\:~@;"1 xy0
NB. ;"1 xy0  razes each row . (> xy0 would be simpler)
NB. \:~"1 sorts the rows
NB. \:~   sorts the entire list
NB. the next thing says to only consider rows where both are less than 2^32

txt =: ,('    ',LF,~}:)"1 ] _4 ;\ ([: < ','10}  3|.'), (', ": )"1 xys
NB. (3|.'), (', ": )"1 xys     is just being kind of silly to wrap it in parens.
NB. the ','10} is specific to n=15 and has to do with the fact that my highest number was 10 digits long.
NB. it's just using fixed-width numbers to determine the spot where the first space is.
NB. this is pretty bad code. I would rewrite this to be more general.
NB. _4 ;\ y  razes takes every four rows and razes them, making a single line of text
NB. (except the comment is wrong. it's every 3 rows)
NB. }: "1 strips the trailing space on each line
NB. LF,~ appends a linefeed
NB. and '     ',indents
NB. and , converts it all to one string
NB. Then I just copied and pasted the output into my source code.
