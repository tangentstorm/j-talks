NB. ------------------------------------------------------------
NB. sandcalc : a sandpile calculator
NB.
NB. (c) copyright 2019 michal j. wallace
NB. http://tangentstorm.com
NB.
NB. available for use under the MIT licence
NB. ------------------------------------------------------------
NB. Quick Sandpile References:
NB. https://en.wikipedia.org/wiki/Abelian_sandpile_model
NB. https://www.youtube.com/watch?v=1MtEUErz7Gg (numberphile)
NB. ------------------------------------------------------------

load 'viewmat'
coinsert each 'jviewmat';'jgl2'

NB. basic sandpile logic ---------------------------------------

settle =: monad define          NB. recursively settle sandpiles with entries > 3
  if. # I. , y > 3 do.
    gt =: y > 3
    NB. alternate rule : if>3, send floor(1/2 * log2(x)) in all directions
    NB. gt =: ((3&<)*[:<.@-:2^.]) y 
    cn =: y - 4 * gt
    up =. }. gt , 0             NB. shift in each of the 4 directions
    dn =. 0 , }: gt             NB. (filling in with 0 rather than wrapping)
    lf =. }."1 gt ,. 0
    rt =. 0 ,. }:"1 gt
    up + dn + lf + rt + cn
  else. y end.
)


NB. color palette ----------------------------------------------

lo =: 16b00000f 16b3f2c5d 16b7878c8 16bc4c4ff  NB. i.4 drawn as shades of blue
hi =: 16bff0000 + 16b001100 * i._16            NB. 4+i.204 are yellow..red
pal =: lo,hi


NB. main animation logic ---------------------------------------

stl =: settle^:_
NxN =: 5 5
ZSP =: ([: stl ] - stl) NxN $ 6    NB. calculate zero for NxN
NB. https://codegolf.stackexchange.com/questions/106963/find-the-identity-sandpile

pen =: 0                           NB. color to draw with
sp0 =: NxN $ 0
sp1 =: ZSP
sp2 =: NxN $ 3

update =: verb define
  sp3 =: settle^:_ sp0 + sp1 + sp2
)

render =: verb define
  spcc sp0;'sp0'
  spcc sp1;'sp1'
  spcc sp2;'sp2'
  spcc sp3;'sp3'
)

spcc =: verb define   NB. view a sandpile in a child control.
  'sp cc' =. y
  'rgb' vmcc (pal {~ (<:#pal) <. sp);cc
  glpaint''
)


NB. create the window ------------------------------------------

scw_close =: verb define
 wd 'psel scw; pclose;'
 wd 'timer 0'
)

NB. Recycle window if we run multiple times:
scw_close^:(wdisparent'scw')''

wd (0 : 0)
pc scw closebutton; pn "sandcalc - a sandpile calculator";
bin h;
  minwh 50 200; cc pal isigraph;
  minwh 200 200; cc sp0 isidraw;
  cc "+" static;
  minwh 200 200; cc sp1 isidraw;
  cc "+" static;
  minwh 200 200; cc sp2 isidraw;
  cc "=" static;
  minwh 200 200; cc sp3 isidraw;
bin z;
pcenter;
rem pmove 250 1000 0 0;
pshow
)


NB. palette to show/select drawing color -----------------------

scw_pal_paint =: verb define
  'rgb' vmcc (,.lo);'pal'
  glfont 'consolas 12'
  glpen 1 [ glbrush glrgb 0 0 0
  gltextcolor glrgb 255 255 255
  for_i. i.4 do.
    yy =. (12+50*i)
    glrect   18, (yy+1), 15 21
    gltextxy 20, yy
    gltext ":i
  end.
  NB. highlight current pen:
  glbrush glrgba 0 0 0 0
  glrect 3, (3+pen*50), 45 45 [ glpen 5 [ glrgb 0 0 0
  glrect 3, (3+pen*50), 45 45 [ glpen 1 [ glrgb 3 $ 255
)


NB. mouse events -----------------------------------------------

whichbox =: verb : '|. <. y %~ 2 {. ".sysdata'
button  =: verb : 'y { 4 }. ".sysdata'
boxsize =: 200 %{.NxN
set_box =: dyad : 'pen (<0>.(<:$x)<.whichbox y) } x'

NB. click the palette to change current pen
scw_pal_mblup =: verb : 'glpaint glsel ''pal'' [ pen =: {. whichbox 50'

NB. left click draws on the input
scw_sp0_mblup =: verb : 'sp0 =: sp0 set_box boxsize'
scw_sp1_mblup =: verb : 'sp1 =: sp1 set_box boxsize'
scw_sp2_mblup =: verb : 'sp2 =: sp2 set_box boxsize'

NB. left drag does the same
NB. scw_sp1_mmove =: scw_sp1_mblup^:([: button 0:)  NB. gave me errors dragging left.
scw_sp0_mmove =: verb : 'if. button 0 do. scw_sp0_mblup _ end.'
scw_sp1_mmove =: verb : 'if. button 0 do. scw_sp1_mblup _ end.'
scw_sp2_mmove =: verb : 'if. button 0 do. scw_sp2_mblup _ end.'

NB. right click to copy the sum to an input
scw_sp0_mbrup =: verb : 'sp0 =: sp3'
scw_sp1_mbrup =: verb : 'sp1 =: sp3'
scw_sp2_mbrup =: verb : 'sp2 =: sp3'

NB. middle click to reset the input
scw_sp0_mbmup =: verb : 'sp0 =: NxN$0'
scw_sp1_mbmup =: verb : 'sp1 =: ZSP'
scw_sp2_mbmup =: verb : 'sp2 =: NxN$3'


NB. animation engine -------------------------------------------

step =: render @ update         NB. glpaint is in each spcc call
sys_timer_z_ =: step_base_
wd 'timer 100'
