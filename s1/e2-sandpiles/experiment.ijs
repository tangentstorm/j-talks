NB. attempt to recreate the experiment.
load'plot'

f =: _1 1 |.!.0"0 _ ]                         NB. shift grid left/right
s =: (+ +/@(_4&* , f , f&.(|:"2))@(3&<))      NB. settle a sandpile
m =: 3 :'s^:_ ? 4 + 50 50 $ 4'                NB. random sandpile
x =: 3 :'+/^:2+./d~:"2 y [ d=.s^:a:4(<?$y)}y' NB. experiment: size of cascade
t =: 3 :'|: x"2]y#,:m _'                      NB. y trials for 1 grid
h =: (<: @ (#/.~) @ (i.@#@[ , I. ))           NB. histogram
l =: 10 ^. 0.0001 + ]                         NB. log 10
n =: % >./                                    NB. normalize
r =: ([: n (l 25*i.100) h l@t)"0 ] 50 # 200   NB. tallies of 50 runs of 200 trials each
a =: (+/%#) r                                 NB. average

'hist' plot a
plot (l a)
plot a,:_0.98^~1+i.#a                         NB. their claim: Dist(x) <--> x^-0.98
