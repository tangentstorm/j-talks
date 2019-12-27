NB. gridpad: a simple sprite editor
NB.
NB. Copyright (c)2019 Michal J Wallace
NB. Free for use under the MIT License.
NB.
NB. See the video where this was made here:
NB. https://youtu.be/CzK2SazvCxM

clear''                                   NB. erase all definitions.

gpw_close =: verb define                  NB. when 'gpw' close button clicked
  wd'psel gpw; pclose; timer 0'
)

gpw_close^:(wdisparent'gpw')''            NB. close old window each time we run.

wd 'pc gpw closebutton; minwh 640 500'    NB. create window 'gpw'
wd 'pn "gridpad: simple sprite editor"'   NB. add title
wd 'bin v'                                NB. vertical bin
wd '  bin h'                              NB.   horizontal bin
wd '    cc pal isigraph;setwh pal 25 400' NB.     narrow isigraph for palette
wd '    set pal sizepolicy fixed fixed'   NB.     keep palette from resizing
wd '    cc img isidraw;setwh img 480 480' NB.     square isidraw canvas
wd '  bin z'                              NB.   /bin
wd '  cc sb statusbar'                    NB.   status bar
wd '  set sb addlabel text'               NB.   ... with status text
wd 'bin z'                                NB. /bin
wd 'pmove 40 480 0 0; ptop; pshow'        NB. position and show window.

require 'viewmat'
coinsert 'jviewmat jgl2'

vmcc =: verb define                       NB. invoke viewmat in a child control
  'pc cc img' =. y                        NB. usage: vmcc(parent;child;pixels)
  wd 'psel ',pc                           NB. select parent control
  glpaint [ 'rgb' vmcc_jviewmat_ img;cc   NB. blit the pixel data and repaint.
)

image =: 32 32 $ 0

NB. overridden below
render =: verb define
  vmcc 'gpw';'img';image
)

NB. call 'render' 10 times a second.
step =: render
sys_timer_z_ =: step_base_
wd 'timer 100'

showgrid =: 1

render =: verb define
  vmcc 'gpw';'img';image
  if. showgrid do.
    'vw vh' =. glqwh glsel'img' [ 'ih iw' =. $ image
    glpen glrgb 255 255 255
    gllines <. 0.5+ (0, ], vw, ])"0 (vh%ih) * i.ih
    gllines <. 0.5+ (], 0, vh,~])"0 (vw%iw) * i.iw
  end.
)

NB. keyboard events are widget-specific, but we want same for img/pal
gpw_pal_char =: gpw_img_char =: verb define
  select. {. sysdata
    case. 'n' do. image =: 32 32 $ 0
    case. 'r' do. image =: ? 32 32 $ 2^24
    case. 'g' do. showgrid =: -. showgrid
  end.
)

NB. overridden below
gpw_img_mmove =: verb define
  wd 'set sb setlabel text *', sysdata
)

NB. overridden below
gpw_img_mmove =: verb define
  wd 'set sb setlabel text *', ": whichbox cellsize''
)

cellsize =: verb define
  (glqwh glsel'img') % |.$ image
)

whichbox =: verb define                   NB. which cell is the mouse over?
  |. <. y %~ 2 {. ".sysdata               NB. (only works inside mouse events)
)

gpw_img_mblup =: verb define
  NB. left click to draw on the image
  mousedraw whichbox cellsize''
)

NB. overridden below
mousedraw =: verb define
  NB. y is the (y,x) coordinates of the pixel to draw
  image =: 16bffffff (< y) } image
)

NB. image =: 16bff6699 (4 28) } image   NB. Missing the '<'

NB. image =: 16b6699ff (8 9; 30 30) } image

gpw_img_mmove =: verb define
  wd 'set sb setlabel text *', ": whichbox cellsize''
  if. lmb'' do. gpw_img_mblup'' end.
)

lmb =: verb : '4 { ".sysdata'             NB. left mouse button

inbounds =: dyad define
  *./ (x >: 0) *. x < y
)

NB. overridden below
mousedraw =: verb define
  NB. y is the (y,x) coordinates of the pixel to draw
  if. y inbounds $image do.
    image =: 16bffffff (< y) } image
  end.
)

NB. default palette (16-color vga text-mode palette)
pal =:      16b000000 16baa0000 16b00aa00 16baa5500
pal =: pal, 16b0000aa 16baa00aa 16b00aaaa 16baaaaaa
pal =: pal, 16b555555 16bff5555 16b55ff55 16bffff55
pal =: pal, 16b5555ff 16bff55ff 16b55ffff 16bffffff

gpw_pal_paint =: verb define
  vmcc 'gpw';'pal';,.pal           NB. ,. makes pal a 2d array
)

NB. pen =: 2  NB. green. just for this slide

mousedraw =: verb define
  NB. y is the (y,x) coordinates of the pixel to draw
  if. y inbounds $image do.
    image =: (pen { pal) (< y) } image
  end.
)

pal_cellsize =: (glqwh glsel 'pal') % 1,#pal

gpw_pal_mblup =: verb define
  NB. left click palette to set pen color
  glpaint glsel 'pal' [ pen =: {. whichbox pal_cellsize
)

pen =: <: # pal  NB. start with last color (white)

gpw_pal_paint =: verb define
  vmcc 'gpw';'pal';,.pal           NB. ,. makes pal a 2d array
  NB. draw a box around the current pen color:
  glbrush glrgba 0 0 0 0  [ h =. {: cellsize =. pal_cellsize
  glrect 3, (3+pen*h), _5 _5 + cellsize [ glpen 5 [ glrgb 0 0 0
  glrect 3, (3+pen*h), _5 _5 + cellsize [ glpen 1 [ glrgb 3 $ 255

  NB. black box around everything:
  glrect 0 0, (glqwh 'pal') [ glpen 1 [ glrgb 0 0 0
)

NB. mouse wheel on either control rotates through palette
gpw_img_mwheel =: gpw_pal_mwheel =: verb define
  pen =: (#pal)|pen-*{:".sysdata NB. sign of last item is wheel dir
  glpaint glsel'pal'
)

wd 'psel gpw'
wd 'menupop "&File"'                      NB. File menu
wd '  menu new  "&New"  "Ctrl+N"'
wd '  menu open "&Open" "Ctrl+O"'
wd '  menu save "&Save" "Ctrl+S"'
wd 'menupopz'

gpw_new_button =: verb define
  image =: ($image) $ 16bffffff                      NB. set to white
)

require 'png'

gpw_open_button =: verb define
  path =. wd 'mb open1 "Load a png file" filename "PNG (*.png)"'
  if. #path do. image =: readpng path end.
)

gpw_save_button =: verb define
  path =. wd 'mb save "Save image" filename "PNG (*.png)"'
  if. #path do. (image+255*2^24) writepng path end.
)

gpw_pal_mbrup =: verb define
  pen =: {. whichbox {: pal_cellsize      NB. same as mblup: set pen
  rgb =: ": 256 256 256 #: pen { pal      NB. get 'r g b' string for old color
  if. #rgb =. wd'mb color ',rgb do.       NB. show system color picker
    c =. 256 #. ".rgb                     NB. turn new string into new color
    pal =: c pen } pal                    NB. update the palette...
  end.
  glpaint glsel 'pal'                     NB. ... and redraw it.
)
