NB. gridpad: a simple sprite editor
NB.
NB. Copyright (c)2019 Michal J Wallace
NB. Free for use under the MIT License.
NB.
NB. See the video where this was made here:
NB. https://youtu.be/CzK2SazvCxM
cocurrent'gridpad'

require 'viewmat png'
coinsert 'jviewmat jgl2'

NB. -- config -----------------------------------------------
NB. override these in your own locale.

NB. startup options: override these before calling gpw_init
gpw_opt_title =: 'gridpad'
gpw_opt_window =: 'nosize'
gpw_opt_timer =: 100
gpw_opt_palv_wh =: 25 400
gpw_opt_imgv_wh =: 480 480
gpw_opt_statusbar =: 1                  NB. show status bar?
gpw_opt_showgrid =: 1                   NB. show the grid by default? (can toggle at runtime)
gpw_opt_colorpick =: 1                  NB. allow color picker
gpw_opt_viewmat =: 'rgb'                NB. viewmat options (x arg to vmcc)
gpw_opt_menu =: noun define
  menupop "&File";
    menu new  "&New"  "Ctrl+N";
    menu open "&Open" "Ctrl+O";
    menu save "&Save" "Ctrl+S";
  menupopz;
  menupop "&View";
    menu grid "Toggle &Grid" "Ctrl-G";
  menupopz;
)

NB. default image.
img =: 32 32 $ 0

NB. default palette (16-color vga text-mode palette)
pal =:      16b000000 16baa0000 16b00aa00 16baa5500
pal =: pal, 16b0000aa 16baa00aa 16b00aaaa 16baaaaaa
pal =: pal, 16b555555 16bff5555 16b55ff55 16bffff55
pal =: pal, 16b5555ff 16bff55ff 16b55ffff 16bffffff

pen =: <: # pal  NB. start with last color (white)

NB. -- initialization ---------------------------------------

gpw_init =: verb define
  NB. TODO: take above configuration arguments as params
  wd'pc gpw closebutton ',gpw_opt_window   NB. create window 'gpw'
  wd'pn *',gpw_opt_title                   NB. add title
  gpw_init_controls''
  if. gpw_opt_statusbar do.
    wd' cc sb statusbar'                   NB.   optional status bar
    wd' set sb addlabel text'              NB.   ... with status text
  end.
  wd 'ptimer ',":gpw_opt_timer
  wd gpw_opt_menu
  wd 'pshow'
  NB. store hwnd in the calling locale. This is so we can call psel later.
  NB. it's one of the few things in wd that doesn't cope with locales.
  gpw_hwnd =: wd 'qhwndp'
  render''                                 NB. force initial render in case timer is 0
)


gpw_init_controls =: verb define
  wd'bin v'                                NB. vertical bin
  wd' bin h'                               NB.   horizontal bin
  wd'  cc palv isigraph'                   NB.     isigraph for palette
  wd'     setwh palv ',":gpw_opt_palv_wh
  wd'     set palv sizepolicy fixed fixed' NB.     keep palette from resizing
  wd'  cc imgv isidraw'                    NB.     square isidraw canvas
  wd'     setwh imgv ',":gpw_opt_imgv_wh
  wd' bin z'                               NB.   /bin
)

gpw_close =: verb define                  NB. when 'gpw' close button clicked
  wd'ptimer 0; pclose'
)

vmcc =: verb define                       NB. invoke viewmat in a child control
  gpw_opt_viewmat vmcc y
:
  'im cc' =. y
  wd 'psel ',":gpw_hwnd
  x vmcc_jviewmat_ (to_rgb im);cc         NB. blit the pixel data
  glpaint glsel cc                        NB. pick child control name and repaint
)

to_rgb =: ]                               NB. map img to rgb
to_argb =: (255*2^24) + to_rgb            NB. and to argb for saving png files
to_pal =: ]                               NB. hook for mapping rgb to indexed palette

NB. -- general routines -------------------------------------

update =: ]


NB. gpw_render is here so you can call it without having to fiddle with locales.
render =: gpw_render0 =: verb define
  vmcc img;'imgv'
  if. gpw_opt_showgrid do.
    'vw vh' =. glqwh glsel'imgv' [ 'ih iw' =. $ img
    glpen glrgb 255 255 255
    gllines <. 0.5+ (0, ], vw, ])"0 (vh%ih) * i.ih
    gllines <. 0.5+ (], 0, vh,~])"0 (vw%iw) * i.iw
  end.
)


whichbox =: verb define                   NB. which cell is the mouse over?
  |. <. y %~ 2 {. ".sysdata               NB. (only works inside mouse events)
)

mbl =: verb : '4 { ".sysdata'             NB. left mouse button


inbounds =: dyad define
  *./ (x >: 0) *. x < y
)

pen_color =: verb define
  NB. this is so you can apply custom mappings between the
  NB. representation in the palette view and the underlying
  NB. data in the image.
  pen { pal
)

img_draw =: verb define
  NB. y is the (y,x) coordinates of the pixel to draw
  img img_draw y
:
  NB. dyadic form uses img as a temp if there are multiple canvases (e.g., sandcalc)
  if. y inbounds $x do.
    render img =: (pen_color'') (< y) } x
  end.
  img
)


NB. -- parent event handler ---------------------------------

gpw_timer =: verb define
  NB. this is called on every tick while the wd ptimer is set
  render update y
)

NB. custom wdhandler.
NB. this is identical to the builtin, but sends errors to smoutput instead of wdinfo
NB. I did this because the built-in one has a nasty habit of generating infinite error loops.
NB. see dec 2019 thread on the j programming list
wdhandler =: 3 : 0
  wdq=: wd 'q'
  wd_val=. {:"1 wdq
  ({."1 wdq)=: wd_val
  if. 3=4!:0<'wdhandler_debug' do.
    try. wdhandler_debug'' catch. end.
  end.
  wd_ndx=. 1 i.~ 3 = 4!:0 [ 3 {. wd_val
  if. 3 > wd_ndx do.
    wd_fn=. > wd_ndx { wd_val
    if. 13!:17'' do.
      wd_fn~''
    else.
      try. wd_fn~''
      catch.
        wd_err=. 13!:12''
        if. 0=4!:0 <'ERM_j_' do.
          wd_erm=. ERM_j_
          ERM_j_=: ''
          if. wd_erm -: wd_err do. i.0 0 return. end.
        end.
        wd_err=. LF,,LF,.(}.^:('|'e.~{.));._2 ,&LF^:(LF~:{:) wd_err
        smoutput 'wdhandler';'error in: ',wd_fn,wd_err
      end.
    end.
  end.
  i.0 0
)

NB. -- shared event handlers --------------------------------

NB. keyboard events are widget-specific, but we want same for img/pal
gpw_imgv_char =: gpw_palv_char =: verb define
  gpw_char''  NB. this is so we can override in one place in the locale
)

gpw_char =: verb define
  NB. TODO: keyboard handler.
	return.
)

NB. mouse wheel on either control rotates through palette
gpw_imgv_mwheel =: gpw_palv_mwheel =: verb define
  pen =: (#pal)|pen-*{:".sysdata NB. sign of last item is wheel dir
  glpaint glsel'palv'
)


NB. -- image view -------------------------------------------

gpw_imgv_mblup =: verb define
  NB. left click to draw on the image
  img_draw whichbox imgv_cellsize''
)

gpw_imgv_mmove =: verb define
  if. gpw_opt_statusbar do. wd 'set sb setlabel text *', ": whichbox imgv_cellsize'' end.
  if. mbl'' do. gpw_imgv_mblup'' end.
)

imgv_cellsize =: verb define
  (glqwh glsel'imgv') % |.$ img
)



NB. -- palette view -----------------------------------------

palv_cellsize =: verb define
  (glqwh glsel 'palv') % 1,#pal
)

gpw_palv_mblup =: verb define
  NB. left click palette to set pen color
  glpaint glsel 'palv' [ pen =: {. whichbox palv_cellsize''
)

gpw_palv_paint =: gpw_palv_paint0 =: verb define
  vmcc (,.pal);'palv'          NB. ,. makes pal a 2d array
  NB. draw a box around the current pen color:
  glbrush glrgba 0 0 0 0  [ h =. {: cellsize =. palv_cellsize''
  glrect 3, (3+pen*h), _5 _5 + cellsize [ glpen 5 [ glrgb 0 0 0
  glrect 3, (3+pen*h), _5 _5 + cellsize [ glpen 1 [ glrgb 3 $ 255

  NB. black box around everything:
  glrect 0 0, (glqwh 'pal') [ glpen 1 [ glrgb 0 0 0
)

gpw_palv_mbrup =: verb define
  if. gpw_opt_colorpick do.
    pen =: {. whichbox {: palv_cellsize''   NB. same as mblup: set pen
    rgb =: ": 256 256 256 #: pen { pal      NB. get 'r g b' string for old color
    if. #rgb =. wd'mb color ',rgb do.       NB. show system color picker
      c =. 256 #. ".rgb                     NB. turn new string into new color
      pal =: c pen } pal                    NB. update the palette...
    end.
    glpaint glsel'palv'                     NB. ... and redraw it.
  end.
)


NB. -- menu handlers ----------------------------------------

gpw_new_button =: verb define
  render img =: ($img) $ 0
)

gpw_dir =: verb define
 if. noun = nc<'gpw_path' do. 0 pick fpathname gpw_path
 else. jpath'~User' end.
)

gpw_open_button =: verb define
  path =. wd 'mb open1 "Load a png file" "',(gpw_dir''),'" "PNG (*.png)"'
  if. #path do. render img =: (to_pal) readpng path end.
)

gpw_save_button =: verb define
  path =. wd 'mb save "Save image" "',(gpw_dir''),'" "PNG (*.png)"'
  if. #path do. (to_argb img) writepng gpw_path =: path end.
)

gpw_grid_button =: verb define
  gpw_opt_showgrid =: -. gpw_opt_showgrid
)
