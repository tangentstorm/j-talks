coinsert'jgl2'
P0 =: j./ 'W2 H2' =: -: 'W H' =: WH =: 640 480

w0_close =: verb define
  wd'psel w0'
  wd'pclose'
  wd'timer 0'
)
w0_close^:(wdisparent'w0')''
wd'pc w0 closebutton; pn "bezier!"'
wd'minwh ',(":WH),'; cc g0 isidraw'
wd'pmove 1900 500 0 0; pshow; ptimer 20'


band =: 1r5*H


steps =: adverb define
  'usage: x (m) steps y  or  m steps/x,y'
:
  x+(m%~y-x)*i.m+1
)

c =: 250 150  NB. control point
r =: 15       NB. radius
e =: 1        NB. exponent

mpos =: 3 : '2{.".sysdata'
drag =: 0
w0_g0_mbldown =: verb define
  drag =: r>|j./c - mpos''
)
w0_g0_mblup =: verb define
  drag =: 0
)
w0_g0_mmove =: verb define
  if. drag do. c =: mpos'' end.
)
w0_g0_mwheel =: verb define
  smoutput 'e =: ',":e =: e - 0.1 * *{:".sysdata
)


interp =: (25 steps/"1)&.|:
ease =: verb : '(e^~interp 0 1) * y'

update =: ]
w0_timer =:  render @ update

render=: verb define
  glsel'g0'

  glpen 0 0 [ glrgb 0 0 0
  bands =: <. ease interp 16b99 16b33 16bff ,: 3#255 NB. 16bff 16b33 16b99
  bandy0 =. <. ease interp 0,H+50
  bandy1 =. H,~}.bandy0
  for_i. i.n=.#bands do.  NB. draw background gradient
    glbrush glrgb i { bands
    glrect 0, (i { bandy0), W, i { bandy1
  end.
  a =. 150 250
  z =. 450 250
  ac =. interp a,:c
  cz =. interp c,:z
  t =. ease 1
  glpen 2 1 [ glrgb 3#0
  gllines <. a,c,z
  glpen 4 1 [ glrgb 3#255
  gllines <. ,(ac*-.t) + cz*t
  glbrush glrgb 3#255
  glellipse (c--:r), r,r
  glpaint''
)
