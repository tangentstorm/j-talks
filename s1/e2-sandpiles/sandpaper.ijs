NB. attempt to recreate the experiment.
cocurrent'sandpaper'

f  =: _1 1 |.!.0"0 _ ]                          NB. shift grid left/right
sp =: (+ +/@(_4&* , f , f&.(|:"2))@(3&<))       NB. settle a sandpile
rs =: 3 :'sp^:_ ? 4 + 50 50 $ 4'                 NB. random sandpile

[       y=.sp^:_ ?. 4 + 5 5 $ 4                 NB. (example 5x5 sandpile)
<"2     d=.sp^:a:4(<?$y)}y                      NB. "animation frames"
<"2     d~:"2 y                                 NB. where is it different?
    +./ d~:"2 y                                 NB. "or" those together

ex =: 3 :'+/^:2+./d~:"2 y [ d=.sp^:a:4(<?$y)}y' NB. experiment: size of cascade
tr =: 3 :'|: ex"2]y#,:rs _'                     NB. trial: run experiment on y copies of new rs''
hs =: (<: @ (#/.~) @ (i.@#@[ , I. ))            NB. histogram (from J wiki)

log =: 10 ^. (0.0001"0)^:(0&=)"0@]

[ lbin =: log 25*i.100                               NB. bins for histogram (log scale)
norm =: % +/                                       NB. normalize


NB. !! copy and paste this one since ctr-enter prints *after* it runs !!
$ r =: ([: norm lbin hs log@tr)"0 ] 50 # 200            NB. tallies for 50 trials, 200 runs each

a =: (+/%#) r                                 NB. a: average (mean)

load'plot'

fmt =: ".0j1":lbin         NB. format as x.x
mxt =: 1,2~:/\ fmt         NB. mask for changes in ticks on x axis
xtl =: ":mxt#fmt           NB. labels
xtp =: ":I.mxt             NB. x tick positions
opts =: 'qt 1920 300; xlabel ',xtl,'; xticpos ',xtp

opts plot (log a)          NB. not exactly log log scale

c =: _0.90^~1+i.#a                            NB. their claim: Dist(x) = x^-0.98

opts plot (log a),:log c                               NB. actual vs claim
opts plot (log a),:_1 + log c                          NB. adjust y intercept... seems to fit.