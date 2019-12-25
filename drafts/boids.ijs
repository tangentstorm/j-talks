coinsert'jgl2'
P0 =: j./ 'W2 H2' =: -: 'W H' =: WH =: 640 480

w0_close =: verb define
  wd'psel w0'
  wd'pclose'
  wd'timer 0'
)
w0_close^:(wdisparent'w0')''

wd'pc w0 closebutton; pn "b01dz!"'
wd'minwh ',(":WH),'; cc g0 isidraw'
wd'pmove 0 0 0 0; pshow'

N=: 250
p=: ,j./ (--:rnd) + ? (2,N) $ rnd =: 800
v=: N$0

avg =: (+/%#)"1
nn =: {."1

update=: verb define
  NB. 'h =: h * dh [ p =: p + h'
  k =: 5
  g =: }.@/:"1 ||-/~p          NB. grade of neighbors by dist

  NB. move toward center of flock
  n =:  g { p                 NB. sorted neighbors
  c0 =. avg k nn n            NB. center = average of k nn
  v0 =. (c0 - p)*0.02         NB. nudge toward centroid

  NB. move away from neighbors that are "too close"
  e =: 10
  v1 =. 0.1 * - +/"1 d * (e>|@|) d=: k nn n - p

  NB. match velocity
  v2 =. 1r8 * v -~ avg k nn g { v

  NB. also slight nudge to the right
  v3 =. 0.001j0 NB. -p * 0.000005

  v =: v + v0 + v1 + v2 + v3
  p =: p + v

  NB. wrap around the sides:
  'xx yy' =: |: +. p
  xx =: xx + +: (W2 * xx<-W2) - (W2 * xx>W2)
  yy =: yy + +: (H2 * yy<-H2) - (H2 * yy>H2)
  p =: xx j. yy
)

band =: 1r5*H
shape =: 0j1 3j0 0j_1
scale =: 4

render=: verb define
glsel'g0'
for_i. i.5 do.  NB. draw background gradient
  glbrush glrgb 16b55 16b88 16bbb - i*3#16b11
  glrect 0, (band*i), W, (band*i+1)
end.
glpen glrgb 0 0 0 0
glbrush glrgb 255 255 255
glpolygon poly=:,/@:+."1 P0 + p + scale * (v%|v) */ shape
glpaint''
)

step=: render @ update
sys_timer_z_=: step_base_
wd 'timer 20'
