NB. ------------------------------------------------------------
NB. core logic for sandpiles
NB. (c) copyright 2019 michal j. wallace
NB. http://tangentstorm.com
NB.
NB. available for use under the MIT licence
NB. ------------------------------------------------------------
require 'viewmat gl2'

NB. basic sandpile logic ---------------------------------------

settle =: monad define          NB. recursively settle sandpiles with entries > 3
  if. # I. , y > 3 do.
    gt =: y > 3
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
pal_val =: 0 1 2 3, 2^2+i.16                   NB. the actual values to draw


NB. sandcolor maps any non-negative integer to the palette
sandcolor =: pal {~ (<:#pal) <.(3+[:<.1.5^.])^:(>3:)"0


NB. draw sandpile in a child control ---------------------------
spcc =: verb define
  'pc cc sp' =. y
  glsel cc [ wd'psel ',pc
  glpaint [ 'rgb' vmcc (sandcolor sp);cc
)
