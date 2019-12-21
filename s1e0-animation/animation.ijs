NB. Code from the "Basic Animation In J" video
NB. https://www.youtube.com/watch?v=uL-70fMTVnw
NB. ------------------------------------------------------------------------

NB. animation demo

load 'viewmat'
coinsert'jgl2'

wd 'pc w0 closeok'                  NB. parent control (window) named 'w0'
wd 'minwh 500 500; cc g0 isidraw;'  NB. add an 'isidraw' child control named 'g0'
wd 'pshow; pmove 40 510 0 0'        NB. show the window at the given coordinates.
wd 'sm focus term'                  NB. session manager: bring terminal to front
wd 'psel w0; ptop'                  NB. bring our window to front

vmcc =: viewmatcc_jviewmat_   NB. viewmat to a child control

step =: render @ update                      NB. each step, we'll call those two in sequence

xy =: 20 20
timestr =: verb define
  6!:0 'YYYY-MM-DD hh:mm:ss.ss'
)

update =: verb define
  im =: ? 10 10 $ 100
  xy =: <. 150 150 + 100 * 2 1 o. 6!:1''
)

render =: verb define
  (50 50 150 ,: 25 25 50) vmcc im;'g0'

  NB. draw the timer
  glbrush glrgb 255 255 255
  glrect xy, 150 30
  gltextxy xy + 8 6
  gltext timestr''

  glpaint''
)

sys_timer_z_ =: step_base_
wd 'timer 10'
