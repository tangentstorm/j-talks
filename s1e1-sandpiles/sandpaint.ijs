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
copy =: grid
showgrid =: 1

update =: verb define
  grid =: settle grid
)

render =: verb define
  spcc 'spw';'sp';grid
  if. showgrid do.
    'vw vh' =. glqwh'sp' [ 'gh gw' =. $ grid
    glpen glrgb 255 255 255
    gllines (0, ], vw, ])"0 (vh%gh) * i.gh
    gllines (], 0, vh,~])"0 (vw%gw) * i.gw
  end.
)

whichbox =: verb : '|. <. y %~ 2 {. ".sysdata'
button  =: verb : 'y { 4 }. ".sysdata'
mousedraw =: dyad : '(pen { num) (<0>.(<:$x)<.whichbox y) } x'

NB. left click or drag draws on the input
spw_sp_mblup =: verb define
 boxsize =. (glqwh 'sp')% $ grid
 grid =: grid mousedraw boxsize
 render''
)
spw_sp_mmove =: verb : 'if. button 0 do. spw_sp_mblup _ end.'

spw_pal_char =: spw_sp_char =: verb define
 select. {. sysdata
   case. 'z' do. render grid =: ($grid)$0          NB. z = all zero
   case. 'r' do. render grid =:?($grid)$4          NB. r = random
   case. 'g' do. render showgrid =: -. showgrid    NB. g = toggle grid lines
   case. ' ' do. step [ wd'timer 0'                NB. space = step
   case. '1' do. wd'timer 1000'                    NB. 1 = pretty slow
   case. '2' do. wd'timer 500'                     NB. ...
   case. '3' do. wd'timer 100'
   case. '4' do. wd'timer 50'
   case. '5' do. wd'timer 25'                      NB. ...
   case. '9' do. wd'timer 1'                       NB. 9 = fast as possible
   case. '0' do. wd'timer 0'                       NB. 0 = stop

   NB. -- original experiment --
   case. 'R' do. render grid =: 4 + ? 100 100 $ 4   NB. R = random 'big' numbers
   case. 'f' do. render grid =: settle^:_ grid      NB. f = fast forward
   case. 'c' do. copy =: grid                       NB. c = copy
   case. 'x' do. render 'grid copy' =: copy;grid    NB. x = swap
   case. '?' do. viewmat copy ~: grid               NB. ? = show diff
 end.
)

NB. palette widget ---------------------------------------------

spw_pal_paint =: verb define
  spcc 'spw';'pal';,.num

  NB. draw text labels over the colors:
  glfont 'consolas 8'
  glpen 1 [ glbrush glrgb 0 0 0
  gltextcolor glrgb 255 255 255
  h =: {: cellsize =: 50 40
  for_i. i.20 do.
    if. i < 16 do. text =. ":i{num else. text =. '2^',":i-2 end.
    xx =. 25 - -: ww =.(8*#text)   NB. center text horizontally
    yy =. 15+h*i                   NB. vertically
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
  pen =: (#pal)|pen-*{:".sysdata NB. sign of last item is wheel dir
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
wd 'timer 500'