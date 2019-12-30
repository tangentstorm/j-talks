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

cocurrent 'sandpaint'
require '~JTalks/s1/e2-sandpiles/sandpiles.ijs'
require '~JTalks/s1/e2-sandpiles/gridpad.ijs'
coinsert 'sandpiles gridpad'

NB. main logic -------------------------------------------------

pen =: 2
img =: 25 25 $ 0
copy =: img

gpw_opt_title =: 'sandpaint'
gpw_opt_timer =: 500
gpw_opt_palv_wh =: 50 800
gpw_opt_imgv_wh =: 800 800
gpw_opt_colorpick =: 0

update =: verb define
  img =: settle img
)

gpw_char =: verb define
 select. {. sysdata
   case. 'n' do. gpw_new_button''                NB. n = new image
   case. 'r' do. render img =:?($img)$4          NB. r = random
   case. 'g' do. gpw_grid_button''               NB. g = toggle grid lines
   case. ' ' do. gpw_timer [ wd'ptimer 0'        NB. space = step
   case. '1' do. wd'ptimer 1000'                 NB. 1 = pretty slow
   case. '2' do. wd'ptimer 500'                  NB. ...
   case. '3' do. wd'ptimer 100'
   case. '4' do. wd'ptimer 50'
   case. '5' do. wd'ptimer 25'                   NB. ...
   case. '9' do. wd'ptimer 1'                    NB. 9 = fast as possible
   case. '0' do. wd'ptimer 0'                    NB. 0 = stop

   NB. -- original experiment --
   case. 'R' do. render img =: 4 + ? 100 100 $ 4 NB. R = 'big' random
   case. 'f' do. render img =: settle^:_ img     NB. f = fast forward
   case. 'c' do. copy =: img                     NB. c = copy
   case. 'x' do. render 'img copy' =: copy;img   NB. x = swap
   case. '?' do. viewmat copy ~: img             NB. ? = show diff
 end.
)


NB. create window ----------------------------------------------

gpw_init''
wd 'pmove 900 100 0 0 ; ptop; pshow;'
