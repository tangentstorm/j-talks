NB. ------------------------------------------------------------
NB. core logic for sandpiles
NB. (c) copyright 2019 michal j. wallace
NB. http://tangentstorm.com
NB.
NB. available for use under the MIT licence
NB. ------------------------------------------------------------
require 'viewmat gl2'

NB. basic sandpile logic ---------------------------------------

settle =: monad define          NB. settle sandpiles with entries > 3
  gt =. y > 3
  up =. }.   gt ,   0           NB. shift in each of the 4 directions
  dn =. }:    0 ,  gt           NB. (filling in with 0 rather than wrapping)
  lf =. }."1 gt ,.  0
  rt =. }:"1 [0 ,. gt
  cn =. _4 * gt                 NB. one more for 4 grains we subtract from the center
  y + up + dn + lf + rt + cn
)

NB. color palette ----------------------------------------------

lo =: 16b00000f 16b3f3f9d 16b7878d8 16bacacff   NB. i.4 drawn as shades of blue
hi =: 16bff0000 + 16b001100 * i._16             NB. 4+i.204 are yellow..red

pal =: lo,hi
num =: 0 1 2 3, 2^2+i.16                        NB. the actual values to draw


NB. map any non-negative integer to the palette
sandcolor =: pal {~ (<:#pal) <.(2+[:<.2^.])^:(>4:)"0


NB. draw sandpile in a child control ---------------------------
spcc =: verb define
  'pc cc sp' =. y
  glsel cc [ wd'psel ',pc
  glpaint [ 'rgb' vmcc (sandcolor sp);cc
)
