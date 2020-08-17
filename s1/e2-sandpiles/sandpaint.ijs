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
img =: 108 192 $ 0
copy =: img

gpo_title =: 'sandpaint'
gpo_timer =: 500
gpo_palv_wh =: 50 1080
gpo_imgv_wh =: 1920 1080
gpo_gridrgb =: 0 0 0
gpo_colorpick =: 0

update =: verb define
  img =: settle img
)

gpw_char =: verb define
 select. {. sysdata
   case. ' ' do. gpw_timer [ wd'ptimer 0'        NB. space = step
   case. '1' do. wd'ptimer 1000'                 NB. 1 = pretty slow
   case. '2' do. wd'ptimer 500'                  NB. ...
   case. '3' do. wd'ptimer 100'
   case. '4' do. wd'ptimer 50'
   case. '5' do. wd'ptimer 25'                   NB. ...
   case. '9' do. wd'ptimer 1'                    NB. 9 = fast as possible
   case. '0' do. wd'ptimer 0'                    NB. 0 = stop

   case. ')' do. render img =: 33 33 $ 0         NB. all 0 (same as ^N)
   case. '!' do. render img =: 33 33 $ 1         NB. all 1
   case. '@' do. render img =: 33 33 $ 2         NB. all 2
   case. '#' do. render img =: 33 33 $ 3         NB. all 3
   case. '$' do. render img =: 33 33 $ 4         NB. all 4
   case. '*' do. render img =: 33 33 $ 8         NB. all 8

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
wd 'pmove 900 100 0 0'
