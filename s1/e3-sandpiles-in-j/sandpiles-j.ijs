(0 : 0)

Bootstrapping the bootstrap environment.
(Using pre-built tools to get data in place.)

For my "sandpiles in J" video, I want to present
various transformations to the following source code:
)


lines =: LF & cut
golf =: lines (0 : 0)
load 'viewmat'
f =: _1 1 |.!.0"0 _ ]
s =: (++/@(_4&*,f,f&.(|:"2))@(3&<))^:_
viewmat s 50 50 $ 4
)

run =: 3 : 0
  NB. this command runs a list of boxed J sentences in sequence
  for_i. i.#y do.
   line =. >i{y
   smoutput line
   ". line
  end.
)
run golf

(0 : 0)
I'm using this as an opportunity to invest in my
systems for building animations and for doing text
transformations, because these align with some of
my long term goals about the presentations I want to
be able to make, and also the idea of a system
bootstrapped from the ground up with formally
specified and verified code.

I want to build a system that lets me specify rules
for transformations on code, and I want to be able
to easily load that source code into the system.

To do that properly for J, the system would have to
support its own J parser. However, I don't need to
start with that: as long as I know what the
intermediate representation is, I can use whatever
existing tools are at hand to parse the text for me.

In fact, for something this small, I could just manually
enter the tokens myself, but doing this as a program in
J is easier and allows me to check my work as I go along.

So, for row, I will use J's built-in lexer to tokenize
this code without having to write a lexer myself:

   [ gtoks =: ~.,;;:&.> golf NB. unique tokens for program 'golf'
┌────┬─────────┬─┬──┬────┬──┬──┬─┬─┬───┬─┬─┬─┬─┬─┬─┬──┬─┬─┬─┬──┬──┬─┬─┬─┬─┬──┬─┬───────┬─────┬─┬─┐
│load│'viewmat'│f│=:│_1 1│|.│!.│0│"│0 _│]│s│(│+│/│@│_4│&│*│,│&.│|:│2│)│3│<│^:│_│viewmat│50 50│$│4│
└────┴─────────┴─┴──┴────┴──┴──┴─┴─┴───┴─┴─┴─┴─┴─┴─┴──┴─┴─┴─┴──┴──┴─┴─┴─┴─┴──┴─┴───────┴─────┴─┴─┘

Probably in my video I want to start at this version of the code,
and show how the two are equivalent.
)


settle =: monad define          NB. settle sandpiles with entries > 3
  gt =. y > 3
  up =. }.   gt ,  0            NB. shift in each of the 4 directions
  dn =. }:    0 ,  gt           NB. (filling in with 0 rather than wrapping)
  lf =. }."1 gt ,. 0
  rt =. }:"1 ]0 ,. gt
  cn =. _4 * gt                 NB. the 4 we subtract from the center
  y + up + dn + lf + rt + cn
)

(s -: settle^:_) 50 50 $ 4      NB. result 1 means the two have the same output.


NB. the lines in the middle all make nouns
NB. but they could be functions on 'gt'

settle1 =: monad define
  gt =. y > 3
  up =. monad : '}.   y ,  0 ' gt
  dn =. monad : '}:    0 ,  y' gt
  lf =. monad : '}."1 y ,. 0 ' gt
  rt =. monad : '}:"1 ]0 ,. y' gt
  cn =. monad : '_4 * y'       gt
  y + up + dn + lf + rt + cn
)
(s -: settle1^:_) 50 50 $ 4      NB. result 1 means the two have the same output.


NB. now we can use a fork train to shorten:
settle2 =: monad define
  gt =. y > 3
  up =. monad : '}.   y ,  0 '
  dn =. monad : '}:    0 ,  y'
  lf =. monad : '}."1 y ,. 0 '
  rt =. monad : '}:"1 ]0 ,. y'
  cn =. monad : '_4 * y'
  y + (up + dn + lf + rt + cn) gt
)
(s -: settle2^:_) 50 50 $ 4      NB. result 1 means the two have the same output.


NB. gt itself is a function of y, and the result is operating on y,
NB. so we can turn this last line into just a function composition applied to y.
settle3 =: monad define
  gt =. monad : 'y > 3'
  up =. monad : '}.   y ,  0 '
  dn =. monad : '}:    0 ,  y'
  lf =. monad : '}."1 y ,. 0 '
  rt =. monad : '}:"1 ]0 ,. y'
  cn =. monad : '_4 * y'
  (+ (up + dn + lf + rt + cn)@gt) y
)
(s -: settle3^:_) 50 50 $ 4      NB. result 1 means the two have the same output.


NB. this is actually somewhat longer, but it puts the final expression in tacit form.
NB. which means we could pull all these local definitions
gt =: monad : 'y > 3'
up =: monad : '}.   y ,  0 '
dn =: monad : '}:    0 ,  y'
lf =: monad : '}."1 y ,. 0 '
rt =: monad : '}:"1 ]0 ,. y'
cn =: monad : '_4 * y'
settle =: monad define
  (+ (up + dn + lf + rt + cn)@gt) y
)
(s -: settle^:_) 50 50 $ 4      NB. result 1 means the two have the same output.


NB. and now we can make the final expression tacit, meaning we don't have to
NB. refer to local variable y, and we're just directly constructing the verb
NB. out of previously defined verbs.
gt =: monad : 'y > 3'
up =: monad : '}.   y ,  0 '
dn =: monad : '}:    0 ,  y'
lf =: monad : '}."1 y ,. 0 '
rt =: monad : '}:"1 ]0 ,. y'
cn =: monad : '_4 * y'
settle =: + (up + dn + lf + rt + cn)@gt
(s -: settle^:_) 50 50 $ 4      NB. result 1 means the two have the same output.


(0 : 0)

When I wrote the golfed version, I didn't actually derive it
this way. I just wrote it from scratch.

But, this line is pretty much the template that was in my head when I wrote it.

So let's compare the two:
)

settle =: + (up + dn + lf + rt + cn)@gt

f =: _1 1 |.!.0"0 _ ]
s =: (++/@(_4&*,f,f&.(|:"2))@(3&<))^:_


(0 : 0)

let's factor out s0

)

s =: (s0)^:_
s0 =: + +/@(_4&*,f,f&.(|:"2))@(3&<)


(0 : 0)

and now let's compare to our verb-in -progress
)

s0 =: + +/@(_4&*,f,f&.(|:"2))@(3&<)    NB. for comparison
s1 =: +    (up+dn+lf+rt+cn)@gt         NB. settle

NB. we can re-arrange the terms a bit to make them line up

s1 =: +    (cn+up+dn+lf+rt)@gt         NB. by commutativity of +
s1 =: +    (_4&*+up+dn+lf+rt)@(3&<)    NB. inline cn and gt

s0 =: + +/@(_4&*,f,f&.(|:"2))@(3&<)    NB. for comparison


(0 : 0)

so s0 replaces the plus signs with commas, adds
the 'plus insert' outside, and replaces the
individual up down left right verbs with
the verb f and a modified version of f.

f is just doing the same as up,:dn
and this modified version of f -- f under transpose at rank 2
is the same as lf,:rt
)


u =: up,:dn                          NB. same as f
v =: lf,:rt                          NB. same as f&.(|:"2)
s1 =: + +/@(_4&*,u,v)@(3&<)          NB. we need to insert + between them

(s -: s1^:_) 50 50 $ 4               NB. result 1 means the two have the same output.



(0 : 0)
if it's true that u and f are the same thing, then we ought to be able to get rid of
v, and therefore the lf and rt verbs, and just do the same thing in s1 for u that s0 does with f.

so let's try it.
)
u =: up,:dn                           NB. same as f
s1 =: + +/@(_4&*,u,u&.(|:"2))@(3&<)   NB. we need to insert + between them
(s -: s1^:_) 50 50 $ 4                NB. result 1 means the two have the same output.


(0 : 0)
now these two are exactly the same, except for the definitions of u and f
)


up =: monad : '}.   y ,  0 '
dn =: monad : '}:    0 ,  y'
u =: up,:dn
s0 =: + +/@(_4&*,f,f&.(|:"2))@(3&<)

f =: _1 1 |.!.0"0 _ ]
s1 =: + +/@(_4&*,u,u&.(|:"2))@(3&<)


(0 : 0)
Okay, so let's back up and talk about what this &.(|:"2) means.

Here's what our four shifting verbs looked like before:
)

up =: monad : '}.     y ,  0 '
dn =: monad : '}:     0 ,  y'
lf =: monad : '}."1   y ,. 0 '
rt =: monad : '}:"1 ] 0 ,. y'

(0 : 0)
On the left we have these two verbs, right curly dot and right curly colon.
Right curly dot is called "behead", and it removes the first item from a list.
Right curly colon is called "curtail", and it removes the last item from a list.

These operate at rank infinity, meaning they operate on the entire list at once.
So we can make that explicit with no change of meaning:
)

up =: monad : '}."_   y ,  0 '
dn =: monad : '}:"_ ] 0 ,  y'
lf =: monad : '}."1   y ,. 0 '
rt =: monad : '}:"1 ] 0 ,. y'

(0 : 0)
Note the use of the right identity for the down and right verbs.
This does nothing except separate the number on the left from the zero on the right.
Otherwise the two numbers would form a single token.

Comma is called append.
Stitch is the same as comma at rank 1. *only when you're talking about 2d arrays*

So just to make this easier to read, I'm going to temporarily introduce a constant, o.
)

o =: 0
up =: monad : '}."_  y ,"_  o'(
lf =: monad : '}."1  y ,"1  o'

dn =: monad : '}:"_  o ,"_  y'
rt =: monad : '}:"1  o ,"1  y'

(0 : 0)

   m =: 5 5 $ _
   m
_ _ _ _ _
_ _ _ _ _
_ _ _ _ _
_ _ _ _ _
_ _ _ _ _
   (up;dn;lf;rt) m
┌─────────┬─────────┬─────────┬─────────┐
│_ _ _ _ _│0 0 0 0 0│_ _ _ _ 0│0 _ _ _ _│
│_ _ _ _ _│_ _ _ _ _│_ _ _ _ 0│0 _ _ _ _│
│_ _ _ _ _│_ _ _ _ _│_ _ _ _ 0│0 _ _ _ _│
│_ _ _ _ _│_ _ _ _ _│_ _ _ _ 0│0 _ _ _ _│
│0 0 0 0 0│_ _ _ _ _│_ _ _ _ 0│0 _ _ _ _│
└─────────┴─────────┴─────────┴─────────┘


Anyway,now we can see that up and left are identical except for the rank
and dn and right are identical except for the rank.

Now you can never increase the rank of a verb. It doesn't really make any sense.
A verb that operates at rank 0 (on atoms) probably doesn't know how to work on lists.
(Especially lists of different shapes and sizes.)

But you *can* decrease the rank. So that means we can define
rt and lf in terms up up and down, but not vice versa.

That's probably okay because if we go back to the original definitions...
)

up =: monad : '}.     y ,  0 '
dn =: monad : '}:     0 ,  y'
lf =: monad : '}."1   y ,. 0 '
rt =: monad : '}:"1 ] 0 ,. y'


(0 : 0)
...then up and down were the simpler choices.

So one way we can do this is:
)

up =: monad : '}. y , 0'
dn =: monad : '}: 0 , y'
lf =: up"1
rt =: dn"1

u =: up,:dn
v =: lf,:rt        NB. this still works
v =: up"1,:rt"1    NB. or this, but not (v =: u"1)


(0 : 0)
So that got rid of two of the definitions, but there
isn't a simple way to apply the "1 transformation
at each prong of the fork, rather than applying it
to the entire fork.

It's probably possible to use J's introspection capabilities
(5!:y) to write a conjunction that does such a thing, but as
far as I know, it's not built into J.

But in this case, it doesn't matter: there's a simple alternative.

We can transpose the grid before and after:

)

u =: up,:dn
v =:  |:&up&|:  ,:  |:&dn&|:        NB. transpose each side before and after
v =: (|:&up     ,:  |:&dn)&|:       NB. we can factor out the "before" part
v =: (|:"2)&( up ,: dn )&|:         NB. to factor out "after", we have to apply at rank 2 because it's now rank 3
v =: (|:"2)&(up,:dn)&(|:"2)         NB. it's safe to put rank 2 on the "before" part. now the before and after are the same.
v =: (up,:dn)&.(|:"2)               NB. now we can use "under"
v =: u&.(|:"2)

s1 =: + +/@(_4&*,u,v)@(3&<)
viewmat s1^:_ ] 50 50 $ 4


(0 : 0)

Note: the important thing isn't that the before and after are the same,
it's that they're inverses of each other.

Removing the rank"2 here is a perfectly valid J program. It just isn't
the program we actually want.

Anyway, now we can inline v:
)

s1 =: + +/@(_4&*,u,u&.(|:"2))@(3&<)

(0 : 0)
Our definitions are now the same except for u vs f:

)

up =: monad : '}. y , 0'
dn =: monad : '}: 0 , y'
u =: up,:dn

f =: _1 1 |.!.0"0 _ ]

s1 =: + +/@(_4&*,u,u&.(|:"2))@(3&<)
s0 =: + +/@(_4&*,f,f&.(|:"2))@(3&<)

(s -: s1^:_) 50 50 $ 4


(0 : 0)

This is kind of a long expression, but it's not that complicated.
The core idea is the verb "rotate":

   i. 3 3
0 1 2
3 4 5
6 7 8

   1 |. i. 3 3
3 4 5
6 7 8
0 1 2

   _1 |. i. 3 3
6 7 8
0 1 2
3 4 5

Rotate is one of a handful of primitive verbs that have variations
which would be really useful if you had a way to pass in one more
argument. Of course we do, and that's by using a conjunction. The
customize conjunction !. is just what we need.

Anyway, |.!.n means rotate, and fill with n. You can replace
the n with whatever you like.


   1 |.!._ i. 3 3
3 4 5
6 7 8
_ _ _


In our case, we want 0.

So now we can re-implement up and dn in terms of shift:
)

up =: monad : '}. y , 0'
dn =: monad : '}: 0 , y'

up =: monad : ' 1 |.!.0 y'
dn =: monad : '_1 |.!.0 y'

(0 : 0)
This is a longer definition, but it gives us some duplicate code we can factor out.

First we can convert to tacit form:
)

up =:  1 |.!.0 ]
dn =: _1 |.!.0 ]
u =: up,:dn

(0 : 0)
The rotate verb applies at rank 1 on the left and rank infinity on the right.

   |.b.0
_ 1 _

(The first number has to do with its use as a monad, which means reverse, then the
second two numbers indicate the rank at which the verb is applied to the left and
right arguments.)

So this means it's expecting a list on the left, and some arbitrary array on the right.
We want our list to mean "shift by these two amounts and return both results."
but as it happens, rotate is going to do something else. (We'll talk about what it
actually does in just a minute).

To make it do what we want (which is basically a simple for-each loop), we can just
adjust the rank
)


u =: 1 _1 |.!.0"0 _ ]
f =: _1 1 |.!.0"0 _ ]


(0 : 0)
Now u and f are exactly the same except for the order, which,
since we're just summing the two versions, doesn't actually matter.

So now we've arrived at my golfed implementation of sandpiles.

This isn't how I arrived at it the first time. I pretty much had
the shape of the program in my head at the start.

This line, basically:

  (+ (up + dn + lf + rt + cn)@gt) y

And I knew that the left and right versions would be the same as
up and down under transposition.

So basically, I probably started by just fiddling around in the j
shell to implement f, then probably wrote s the same way. Ususally
I'm testing my function out on some tiny array as I go along, so
I can make sure it does what I expect.

Anyway, I published that video, challenged anyone watching it to
try and produce a shorter version.

And someone rose to the challenge!

https://www.reddit.com/r/apljk/comments/fo472r/video_sandpiles_cellular_automata_in_j/fle394x?utm_source=share&utm_medium=web2x

)

jw=:(+[:(_4&*+[:+/((,-)(,:|.)0 1)|.!.0])3&<)^:_     NB. jitwit's version
(s -: jw) 5 5 $ 4

(0 : 0)
What's going on here?

   sj
(+ ([: (_4&* + [: +/ (4 2$0 1 1 0 0 _1 _1 0) |.!.0 ]) 3&<))^:_
)

sj =:(+ [: (_4&*+[:+/((,-)(,:|.)0 1)|.!.0]) 3&<)     NB. remove the ^:_

sj =: + [: (_4&*+[:+/((,-)(,:|.)0 1)|.!.0]) 3&<      NB. drop parens
NB.   _ __ ________________________________ ___    4 verbs
NB.   _ ___________________________   2 verbs
s0 =: + +/@(_4&*,f,f&.(|:"2))@(3&<)


(0 : 0)

There are some small differences in the way the verbs are composed.
Jitwit uses a train of 4 verbs compared to my 2. Either way, it's still
even numbered, which makes it a hook.

(except the [: changes how the fork is applied)

So earlier I glossed over the left argument for shift and rotate.
The reason it looks at rank one for the left argument is because
each number in the list corresponds to an amount to shift on each axis.
so:
)

up =:  1 |.!.0 ]
dn =: _1 |.!.0 ]
u =: up,:dn


up =:  1 0 |.!.0 ]
dn =: _1 0 |.!.0 ]
lf =:  0 1 |.!.0 ]
rt =:  0 _1|.!.0 ]
u =: up,:dn
v =: lf,:rt


(0 : 0)

But because it operates on rank 1, it means if you supply a rank 2 array
on the left, you get the "foreach" for free. So now we can drop the transpose,
and do all four at once:
)

g =: u,v
g =: (1 0, _1 0, 0 1,: 0 _1) |.!.0 ]
s1 =: ++/@(_4&*,g)@(3&<)
(s -: s1^:_) 5 5 $ 4



(0 : 0)
So jitwit's main trick is to generate that left argument concisely.
Or rather any permutation of that left argument.

Jitwit's version is in a slightly different order:
)
n =: 4 2$0 1 1 0 0 _1 _1 0
n =: 0 1, 1 0, 0 _1,: _1 0
n =: (,-)(,:|.)0 1

(0 : 0)
They've also re-arranged some things, replacing composition
with use of the verb cap, but it doesn't actually affect
the length:
)
jw =: +[:(_4&*+[:+/n|.!.0])3&<
s1 =: ++/@(_4&*,n|.!.0])@(3&<)   NB. (f g@h)  <-->  (f[:g h)
s1 =: +[:+/@(_4&*,n|.!.0])3&<    NB. shaves off one character by swapping [: for @()
(s -: s1^:_) 5 5 $ 4

(0 : 0)
Can we find a shorter definition of n, or any permutation of those rows?
I don't see a way to improve on (,-), but these shave off two
characters each:
)
n =: (,-)(,:|.)0 1
n =: (,-)=/~i.2
n =: (,-)2]\i:1

(0 : 0)
Picking the last version and inlining leaves us with the final golfed version:
)

s1 =: +[:+/@(_4&*,((,-)2]\i:1)|.!.0])3&<

(0 : 0)
If you can beat that, leave your code in a comment. :)

Of course, in the real world, I'd rather optimize for clarity.
And while I think a shorter program is often a better program,
adding code just to compress a string of numbers just makes
the reader do extra work.

So given what I know now, I'd probably write something like this:
)
load 'viewmat'
d =: 0 1, 1 0, 0 _1,: _1 0          NB. directions to shift
s =: + [: +/@(_4&*, d|.!.0]) 3&<    NB. sandpiles step
viewmat s^:_ [ 50 50 $ 4
