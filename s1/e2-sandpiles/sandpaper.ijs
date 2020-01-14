NB. attempt to recreate the experiment.
cocurrent'sandpaper'

f =: _1 1 |.!.0"0 _ ]                         NB. shift grid left/right
s =: (+ +/@(_4&* , f , f&.(|:"2))@(3&<))      NB. settle a sandpile
m =: 3 :'s^:_ ? 4 + 50 50 $ 4'                NB. random sandpile

[       y=.s^:_ ?. 4 + 5 5 $ 4                NB. (example 5x5 sandpile)
<"2     d=.s^:a:4(<?$y)}y                     NB. "animation frames"
<"2     d~:"2 y                               NB. where is it different?
    +./ d~:"2 y                               NB. "or" those together

e =: 3 :'+/^:2+./d~:"2 y [ d=.s^:a:4(<?$y)}y' NB. experiment: size of cascade
t =: 3 :'|: e"2]y#,:m _'                      NB. trial: run experiment on y copies of new m''
h =: (<: @ (#/.~) @ (i.@#@[ , I. ))           NB. histogram (from J wiki)
l =: 10 ^. 0.0001 + ]                         NB. log10(y), avoiding y=0

[ b =: l 25*i.100                             NB. bins for histogram (log scale)
n =: % +/                                     NB. normalize


NB. !! copy and paste this one since ctr-enter prints *after* it runs !!

$ r =: ([: n b h l@t)"0 ] 50 # 200            NB. tallies for 50 trials, 200 runs each

a =: (+/%#) r                                 NB. average

load'plot'
plot (l a)                                    NB. log log scale

c =: _0.90^~1+i.#a                            NB. their claim: Dist(x) = x^-0.98
plot (l a),:l c                               NB. actual vs claim
plot (l a),:_1 + l c                          NB. adjust y intercept... seems to fit.