NB. ------------------------------------------------------------
NB. sandpaint: a sandpile explorer
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

require 'viewmat'
coinsert 'jviewmat jgl2'
require '~JTalks/s1e1-sandpiles/sandpiles.ijs'

NB. main logic -------------------------------------------------

pen  =: 2
grid =: 25 25 $ 0
showgrid =: 1
running =: 1

update =: verb define
  if. running do. grid =: settle grid end.
)

render =: verb define
  spcc 'spw';'sp';grid
  if. showgrid do.
    'vw vh' =. glqwh'sp' [ 'gw gh' =. $ grid
    glpen glrgb 255 255 255
    gllines (0, ], vw, ])"0 ] (vh%gh) * i.gh
    gllines (], 0, vh,~])"0 ] (vw%gw) * i.gw
  end.
)

whichbox =: verb : '|. <. y %~ 2 {. ".sysdata'
set_box =: dyad : '(pen { pal_val) (<0>.(<:$x)<.whichbox y) } x'

NB. left click or drag draws on the input
spw_sp_mblup =: verb define
 boxsize =. (glqwh 'sp')% $ grid
 grid =: grid set_box boxsize
)
spw_sp_mmove =: verb : 'if. button 0 do. spw_sp_mblup _ end.'

NB. palette widget ---------------------------------------------

spw_pal_paint =: verb define
  NB. vmcc draws the colored backgrounds:
  'rgb' vmcc (,.pal);'pal'

  NB. now manually draw the text labels:
  glfont 'consolas 8'
  glpen 1 [ glbrush glrgb 0 0 0
  gltextcolor glrgb 255 255 255
  h =: {: cellsize =: 50 40
  for_i. i.20 do.
    yy =. (15+h*i)
    if. i < 16 do. text =. >i{pal_txt
    else. text =. '2^',":i-2 end.
    xx =. 25 - -: ww =.(8*#text)
    glrect xx, yy, (ww+1), 14
    gltextxy (2+xx),yy
    gltext text
  end.

  NB. ... and a box around the current color:
  glbrush glrgba 0 0 0 0
  glrect 3, (3+pen*h), _5 _5 + cellsize [ glpen 5 [ glrgb 0 0 0
  glrect 3, (3+pen*h), _5 _5 + cellsize  [ glpen 1 [ glrgb 3 $ 255
)

NB. click the palette to choose a color:
spw_pal_mblup =: verb define
  glpaint glsel 'pal' [ pen =: {. whichbox 40
)


NB. mouse wheel on either control rotates through palette
spw_sp_mwheel =: spw_pal_mwheel =: verb define
  pen =: (#pal)|pen-*{:".sysdata NB. absolute val of last item is wheel dir
  glpaint glsel'pal'
)


NB. create window ----------------------------------------------

spw_close =: verb define
 wd 'psel spw; pclose'
 wd 'timer 0'
)

NB. Recycle window if we run multiple times:
spw_close^:(wdisparent'spw')''

wd 0 : 0
pc spw closebutton; minwh 640 640;
pn "sandpaint: sandpile explorer";
bin h;
  minwh 50 800; cc pal isigraph;
  set pal sizepolicy fixed fixed;
  minwh 800 800; cc sp isidraw;
bin z;
pmove 900 100 0 0 ; ptop; pshow;
)

NB. animation engine -------------------------------------------
step =: render @ update
sys_timer_z_ =: step_base_
wd 'timer 50'
