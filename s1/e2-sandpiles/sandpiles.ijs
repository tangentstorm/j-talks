NB. ------------------------------------------------------------
NB. core logic for sandpiles
NB. (c) copyright 2019 michal j. wallace
NB. http://tangentstorm.com
NB.
NB. available for use under the MIT licence
NB. ------------------------------------------------------------
cocurrent'sandpiles'

NB. basic sandpile logic ---------------------------------------

settle =: monad define          NB. settle sandpiles with entries > 3
  gt =. y > 3
  up =. }.   gt ,   0           NB. shift in each of the 4 directions
  dn =. }:    0 ,  gt           NB. (filling in with 0 rather than wrapping)
  lf =. }."1 gt ,.  0
  rt =. }:"1 [0 ,. gt
  cn =. _4 * gt                 NB. the 4 we subtract from the center
  y + up + dn + lf + rt + cn
)

NB. color palette ----------------------------------------------

pal =: 0 1 2 3, 2^2+i.16                        NB. the actual values to draw

lo =: 16b00000f 16b3f3f9d 16b7878d8 16bacacff   NB. i.4 drawn as shades of blue
hi =: 16bff0000 + 16b001100 * i._16             NB. 4+i.204 are yellow..red
rgb =: lo,hi

NB. map any non-negative integer to the palette
to_rgb =: rgb {~ (<:#rgb) <.(2+[:<.2^.])^:(>4:)"0

NB. map rgb colors back to the palette
shl =:  32 b. ~
to_pal =: (#pal) | rgb i. (1 shl 24)&|


NB. palette widget ---------------------------------------------

gpw_palv_paint =: verb define
  gpw_palv_paint0''                              NB. call original

  NB. draw text labels over the colors:
  glfont 'consolas 8'
  glpen 1 [ glbrush glrgb 0 0 0
  gltextcolor glrgb 255 255 255
  h =. {: palv_cellsize''
  for_i. i.#pal do.
    if. i < 16 do. text =. ": i { pal else. text =. '2^',":i-2 end.
    xx =. 25 - -: ww =.(8*#text)   NB. center text horizontally
    yy =. 15+h*i                   NB. vertically
    glrect xx, yy, (ww+1), 14
    gltextxy (2+xx),yy
    gltext text
  end.
)
