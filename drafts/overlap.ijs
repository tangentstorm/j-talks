NB. -------------------------------------------
NB.
NB. drag and drop rectangles with overlap detection
NB.
NB. (c) 2019 by michal j wallace
NB.   http://tangentstorm.com/
NB.
NB. free for use under the MIT license.
NB.   https://opensource.org/licenses/MIT
NB.
NB. -------------------------------------------
coinsert 'jgl2'

NB. -- animation engine ------------------------

wd 'pc w0 closeok'                           NB. parent control (window) named 'w'.
wd 'pn animation engine'                     NB. give it a title if you want
wd 'minwh 500 500; cc g0 isidraw'            NB. add an 'isidraw' child control named 'g'
wd 'pshow'                                   NB. show the window at the given coordinates.

step =: glpaint@render@update
sys_timer_z_ =: step_base_                   NB. set up global timer to call step
wd 'timer 40'                                NB. start timer at 10 frames per second
update =: render =: ]                        NB. initial "implementations"

NB. -- custom code -----------------------------

mp =: 0 0                                        NB. mouse position
mb =: 3 $ 0                                      NB. isigraph only tracks 3 buttons
mw =: 0                                          NB. mouse wheel

on_mmov0 =: 3 :'mp =: 2 {. ".sysdata'         NB. mouse position
on_mwhl =: 3 :'mw =: mw + 11 { ".sysdata'    NB. mouse wheel
on_mbtn =: 3 :'mb =: 4 5 8 { ".sysdata'      NB. mouse buttons
w0_g0_mblup =: w0_g0_mbldown =: on_mbtn
w0_g0_mbrup =: w0_g0_mbrdown =: on_mbtn
w0_g0_mbmup =: w0_g0_mbmdown =: on_mbtn


rgb =: 256 #.^:_1 ]

xy =: 10 10                                      NB. position of timer
boxwh =: 15 15 
boxsp =: 20 0
center =. 250 250
boxes =: center +"1 (boxwh + boxsp) *"1 (i:2),.0 

(reset =: 3 : 0)''
  dxy0 =: boxes =: 0j0
  for_i. x: 1+i.5 do.
    dxy0 =: dxy0, d=. r. (2*i) %~ o.i.4*i
    boxes =: boxes, (i*32) * d
  end.
  boxes =: <. center +"1 +. boxes
  over  =: 0 $~ # boxes
  '' return.
)

dragxy0 =: 0 0
offset  =: 0 0
subject =: 0$0

on_mmov =: 3 : 0
  on_mmov0''
)

w0_g0_mbldown =: verb define
  dragxy0 =: mp [ on_mbtn''
  if. # subject =: {. I. over do.
    subjxy0 =: subject { boxes
  end.
)

w0_g0_mblup =: verb define
  on_mbtn''
  subject =: 0$0
)

w0_g0_mmove =: verb define
  on_mmov''  
  if. #s=.subject do. boxes =: (subjxy0 + mp - dragxy0) s } boxes end.
)

update =: verb define
  over =: (mp >:"1 boxes) *./"1@:*. (mp <:"1 boxes +"1 boxwh)
  dxy =: +. (dxy0) * 1r3* 1 o. 6!:1''
  boxes =: boxes +"1 + dxy 
)

render =: verb define
  glfill rgb 16b336699ff
  glbrush glrgb 4 $255
  glrect xy, 140 30
  gltextxy xy + 8 6
  gltext ":mp,mb,mw

  for_i. i.# boxes do.
    glbrush glrgb rgb 16b555555 16bcccccc {~ (i{over)
    glellipse (i{boxes),"1 boxwh
  end.
)
wd'timer 20'
glpaint@render@reset''