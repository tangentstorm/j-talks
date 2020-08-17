0NB. attempt to recreate the experiment.
cocurrent'sandpaper'

NB. here's our golfed sandpile verb

f  =: _1 1 |.!.0"0 _ ]                          NB. shift grid left/right
sp =: (+ +/@(_4&* , f , f&.(|:"2))@(3&<))       NB. settle a sandpile


NB. this generates a random unstable sandpile and lets it settle down.
NB. they used 50 x 50 in the paper, so we'll do the same.

rs =: 3 :'sp^:_ ? 4 + 50 50 $ 4'                NB. random sandpile


NB. And now we want to run the simulation
NB. after setting a random cell to four,
NB. but also capture every frame of the animation.

[       y=.sp^:_ ?. 4 + 5 5 $ 4                 NB. (example 5x5 sandpile)
<"2     d=.sp^:a:4(<?$y)}y                      NB. "animation frames"

NB. that way we can see where it's
NB. different from the original on each frame.

<"2     d~:"2 y                                 NB. where is it different?

NB. Now we just insert the logical "OR"
NB. operator between all those frames and see
NB. every cell that was touched.

    +./ d~:"2 y                                 NB. "or" those together


NB. Let's cram all that together into one verb

ex =: 3 :'+/^:2+./d~:"2 y [ d=.sp^:a:4(<?$y)}y' NB. experiment: size of cascade


NB. and then this next one lets us run as many experiments
NB. as we like on that one initial configuration.
NB. The pound sign is making copies, so I'm acting as if
NB. we reset the simulation before each change,
NB. rather than saving the changes each step.

tr =: 3 :'|: ex"2]y#,:rs _'                     NB. trial: run experiment on y copies of new rs''


NB. That's pretty much it. The next few lines are just
NB. functions we'll need to make a log log plot of the affected area sizes.

hs =: (<: @ (#/.~) @ (i.@#@[ , I. ))            NB. histogram (from J wiki)
log =: 10 & ^.                                  NB. log is just log 10
[ lbin =: }. log 25*i.100                       NB. bins for histogram (log scale)
norm =: % +/                                    NB. normalize


NB. !! copy and paste this one since ctr-enter prints *after* it runs !!

$ r =: ([: norm lbin hs log@tr)"0 ] 50 # 200    NB. tallies for 50 trials, 200 runs each

a =: (+/%#) r                                   NB. a: average (mean)
load'plot'

fmt =: ".0j1":lbin                              NB. format as x.x
mxt =: 1,2~:/\ fmt                              NB. mask for changes in ticks on x axis
xtl =: ":mxt#fmt                                NB. labels
xtp =: ":I.mxt                                  NB. x tick positions

opts =: 'qt 1920 300; xlabel ',xtl,'; xticpos ',xtp

log =: 10 ^. (0.0001"0)^:(0&=)"0@]              NB. log but strip out zeros

opts plot (log a)                               NB. not exactly log log scale

c =: _0.90^~1+i.#a                              NB. their claim: Dist(x) = x^-0.98

opts plot (log a),:log c                        NB. actual vs claim
opts plot (log a),:_1 + log c                   NB. adjust y intercept... seems to fit.
