NB. --- reshape idea ---
vm =: EMPTY [ ]

0 0 1 0 0 1 0 0 1
# 0 0 1 0 0 1 0 0 1

9 $ 0 0 1

NB. easy for every third but what about every 20?

19$0,1  NB. no. only 19 long, plus wrong pattern
(19$0),1  NB. j executes right to left
1,~19$0  NB. save a character

NB. special trick:

I. 19 1

NB. why is this a thing?
NB. lets you take arbitrary copies
'ab' {~ I. 19 2
'abcd' {~ I. 9 2 3

NB. okay so: now we can do the lightswitches

9 $ I. 2 1
9 $ I. 1 1
9 $ I. 0 1  NB. even works for zero

NB. but how to get all of them?

{{9 $ I. y,1}} i.10
{{y,1}} i.10
I. {{y,1}} i.10
9 $  I. {{y,1}} i.10

NB. so fix with "0
{{9 $ I. y,1}}"0 i.10
{{9 $ I. y,1}}"0 i.9
{{100 $ I. y,1}}"0 i.100


vm {{100 $ I. y,1}}"0 i.100

0=|/~1+i.12


a=: 0=|/~1+i.100
b=: {{100 $ I. y,1}}"0 i.100
a -: b

vm a

NB. if we want to see what it looked like at each step:

vm ~:/\a

NB. 


NB. just look at the final line, so we can drop the scan
~:/a NB. that's xor


NB. so 

NB. how many times are the lights switched?
+/a
NB. even or odd?
2| +/a

NB. except the rooms are numbered from 1-100

1+I.~:/a

NB. What in TARNATION?!

NB. what do these numbers mean?

NB. let's go back to the sums:
+/a



NB. divisibility table
0=|/~1+i.12

NB. factors for 6
1+I. 5 { |: 0=|/~1+i.12

{{<1+I.y}}"1 |: 0=|/~1+i.12

NB. let's put some labels here:
;/1+i.12

(;/1+i.12) ,. {{<1+I.y}}"1 |: 0=|/~1+i.12

NB. number of factors
(;/1+i.12) ,: {{< # I.y}}"1 |: 0=|/~1+i.12

{{#I.y}}"1 |: 0=|/~1+i.12
2|{{#I.y}}"1 |: 0=|/~1+i.12
1+I. 2|{{#I.y}}"1 |: 0=|/~1+i.12
1+I. 2|{{#I.y}}"1 |: 0=|/~1+i.1000


NB. so why is it square numbers have odd factors?

NB. -- prime exponents --

q: 360


NB. want some way to group the exponents:

</.~ q: 360
#/.~ q: 360


NB. but this fails:
#/.~ q: 100
#/.~ q: 36


NB. so j provides a builtin:
_ q: 100
_ q: 360

NB. -- so just a quiz. 
_ q: 500


NB. take two of prime 0, zero of prime 1, three of prime 2
p:i.3
2 0 3 # p:i.3
q: 500

NB. so that's why the prime exponents of 500 are 2 0 3
_ q: 500


NB. by the way, what's the inverse?

*/ 2 0 3 # p:i.3

_ q: inv 2 0 3 



NB. so that's prime exponents

NB. why do square numbers have an odd number of factors?
NB. let's demonstrate that square numbers have all even
NB. prime exponents.

   pe =: _ & q: inv
   pe 3 2 1
360

NB. ...

NB. so that shows every square number has all even 
NB. exponents and vice versa

NB. how does that map to the number of factors?




NB. factors of 6
1+I. 5 { |: 0=|/~1+i.12

_ q: 6

NB. It has two prime factors:

+/_ q: 6

NB. and for the actual factors, we just pick
NB. some subset of the prime factors to include or not:
NB. since we have two primes, 
NB. you can think of that as listing all the two bit numbers.
NB. the first bit says whether two is a factor of the factor.
NB. the second bit says whether three is a factor.
NB. so what are all the two-bit numbers?
i.2^2

NB. and what are the actual bits?
(#:i.2^2)


(#:i.2^2) <@#  2 3

NB. all factors of 6 in some order
*/&> (#:i.2^2) <@#  2 3


NB. but let's just look at the lists
(#:i.2^2) <@#  2 3

NB. what if we change the 2 to another 3?
(#:i.2^2) <@#  3 3
NB. we got a duplicate

NB. now we have all the factors of 9, but 
NB. this time we have duplicates.
NB. same with 2 2
(#:i.2^2) <@#  2 2

NB. what about 2 2 3?
NB. (three prime factors so now we have to count to 2^3 and get eight cases)
(#:i.2^3) <@#  2 2 3


NB. so let's start with one prime factor a
NB. that means the number is a prime (it's a) 
NB. and only has one and itself as factor.
{{(#:i.2^#y) <@/:~@# |.y}} 'a'


NB. special case for 1
{{(#:i.2^#y) <@/:~@# :: a: |.y}} ''


NB. if we add another prime factor b, then
NB. its like duplicating this list, and adding b
NB. to each item:
{{(#:i.2^#y) <@/:~@# |.y}} 'ab'


NB. but if we do that with a, we get a duplicate.
{{(#:i.2^#y) <@/:~@# |.y}} 'aa'

NB. now let's add b:
{{(#:i.2^#y) <@/:~@# |.y}} 'aab'

NB. we have four new items in the list.
NB. but we had duplicates before, so we add one
NB. duplicate for every duplicate that existed.
NB. so we've doubled the number of duplicates,
NB. which means we have an even number of duplicates.
NB. since we double the length of the list each time
NB. the complete list with duplicates is always even length.
~. {{(#:i.2^#y) <@/:~@# |.y}} 'aab'
# ~. {{(#:i.2^#y) <@/:~@# |.y}} 'aab'


NB. so the length of the complete list is always even.
NB. and there's always some number of duplicates.
NB. and the number of duplicates is either even or odd.
NB. 


pairs =: ({. ,. |.@}.)~ -:@#
pairs i.8

powset =: {{(#:i.2^#y) <@/:~@# |.y}}


pairs =: [:(,:|.)/@|:_2[\]

oldnew =: {{ |: _2 ]\ y}}


NB. let's use letters so the display is smaller
NB. and put them in an order that's easier to see
{{(#:i.2^#y) <@/:~@# |.y}} 'ab'


{{(#:i.2^#y) <@/:~@# |.y}} 'aa'


NB. if we add a new prime factor, we're just copying
NB. the list we had before, and adding the new factor to each one.
{{(#:i.2^#y) <@/:~@# |.y}} 'abc'


NB. but if we add an existing prime factor,
NB. then half the new entries are copies.
{{(#:i.2^#y) <@/:~@# |.y}} 'abb'


{{(#:i.2^#y) <@# |.y}} 'ab'



NB. with just ab, half had an a, half did not.
NB. we have 4 unique factors. an even number.

{{(#:i.2^#y) <@# |.y}} 'aba'
{{(#:i.2^#y) <@/:~@# |.y}} 'aba'
NB. add another a.
NB. we make a copy of what we had, and add an a to each one
NB. but half already had an a, and it was an even number.

{{(#:i.2^#y) <@/:~@# |.y}} 'abc'

NB. so we add an a to all the ones that didn't have an a
NB. but those are all in the set.
NB. we add a second a to all the ones that did have an a.
NB. those become new items.


NB. prime factors
q:6

NB. --- number of factors ----

NB. most switches 
1+I. 2 = +/a   NB. primes
1+(i. >./) +/a