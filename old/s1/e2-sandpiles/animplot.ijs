NB. animated plots

cocurrent'xxx'
load'plot'
coinsert each 'jgl2'; 'jzplot'

dist =: ([: -/ >./,<./)@]
bins =: ([: }. (<./)@] + i.@>:@[ * >:@[ %~ dist)
hist =: <: @ (#/.~) @ (i.@#@[ , I.)

wn =: 3 :'? 2000#51'
bn =: 3 :'| 100 + +/\ 1 _1 {~ ?2000#2'  NB. abs to avoid negative values

(init_data =: verb define)''
  wt =: 'animated plot'       NB. parent name (window title)
  wh =: 720 200               NB. width and height of the window
  t =: 0x                     NB. tick counter
  s =: 0$0                    NB. s: data series at each tick
  n =: 16                     NB. number of bins
  h =: n$0                    NB. latest histogram
  a =: 0$0                    NB. all histograms (so we can average them)
  lh =: h [ la =: a           NB. log scale h and a
)

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

log =: 10 ^. 1:^:(0&>:)"0
lb =: log 25*i.100                           NB. bins for histogram (log scale)
nm =: % +/                                      NB. normalize
fn =: 3 : 'tr 200'

update =: verb define       NB. build a time series to display
  s =: fn ''
  h =: (n&bins hist ]) s
  lh =: (n&bins hist ]) log s    NB. ignore anything <= 0
  if. t do. a=: a,h else. a =: ,:h end.
  if. t do. la=: la,lh else. la =: ,:lh end.
  t =: t + 1
)

render =: verb define       NB. put pd commands here
  draw_data''
  draw_hist''
  draw_logs''
)

w0_g0_char =: w0_g1_char =: w0_g2_char =: verb define
  init_data''
  select. {.":sysdata
    case. '0' do. fn =: (200$0)"_
    case. '1' do. fn =: wn
    case. '2' do. fn =: bn
    case. '3' do. fn =: 3 : 'tr 200'
  end.
  0$0
)


nolabels =: 3 : 'pd ''frame 1; axes 1 1; labels 0 0;'''

draw_data =: verb define
  cc 'g0'
  nolabels''
  pd 'color red'
  pd s
  paint''
)

draw_hist =: verb define
  cc 'g1'
  pd 'sub 2 1'
  pd 'new; type bar; color red'
  nolabels''
  pd h
  pd 'new; type bar'
  nolabels''
  pd (+/%#) a
  paint''
)

draw_logs =: verb define
  cc 'g2'
  pd 'sub 2 1'
  pd 'new; type marker; color red'
  nolabels''
  pd log lh
  pd 'new; type marker'
  nolabels''
  pd log (+/%#) la
  paint''
)


trap_z_ =: verb define      NB. halt timer to avoid infinite modal error msg death loop
  wd 'ptimer 0'
  smoutput LF,(13!:12''),'timer stopped.'
)

signal_jzplot_=:13!:8&12 [ trap


pc =: verb define        NB. choose where to draw pd commands
  wd 'psel ', PForm_jzplot_=: y
  PFormhwnd=: wd 'qhwndp'
)

cc =: verb define
  NB. pd 'reset' [ glsel y [ PIdhwnd_jzplot_ =: wd 'qhwndc ', PId_jzplot_=: y
  pd 'reset' [ glsel y [ PIdhwnd=: wd 'qhwndc ', PId=: y
)

paint =: verb define        NB. repaint current window on demand
  glpaint @ ppaint''
)

w0_timer =: verb define         NB. animation engine, with error trap
  wd'psel w0'
  try. paint render [ update''
  catch. trap'' end.
)


3 : 0'' NB. create the window if it doesn't exist
 init_data''
 if. -. wdisparent 'w0' do.
   wd'pc w0 closeok; pn "',wt,'";'
   wd'bin h'
   wd'  bin v'
   wd'    minwh 640 20;  cc s0 static; cn "raw data"'
   wd'    minwh 640 480; cc g0 isidraw flush;'
   wd'  bin z'
   wd'  bin v'
   wd'    minwh 480 20;  cc s1 static; cn "histograms (current and average)"'
   wd'    minwh 480 480; cc g1 isidraw flush;'
   wd'  bin z'
   wd'  bin v'
   wd'    minwh 240 20;  cc s2 static; cn "log-log plot (current and average)"'
   wd'    minwh 240 480; cc g2 isidraw flush;'
   wd'  bin z'
   wd'bin z'
   wd'pshow; pcenter; ptimer 100'
  end.
)
