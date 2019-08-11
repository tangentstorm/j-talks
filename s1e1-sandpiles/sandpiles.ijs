load 'viewmat'
vmcc =: glpaint_jgl2_@viewmatcc_jviewmat_

base =: 2 : 'v&(#.^:_1)y'

sp =: verb define
  3 3 $ _9 {. [base 4] y         NB.  monad: construct the yth 3*3 sandpile
:
  (x,x) $ (-x*x) {. [base 4] y   NB.  dyad: construct the yth x*x sandpile
)

rsp =: monad define
  if.     y -: ''  do. ? 3 3 $ 4
  elseif. 1 = #,y  do. ? (y,y) $ 4
  elseif.          do. ? y $ 4 end.
)

settle =: monad define          NB. recursively settle sandpiles with entries > 3
  if. # I. , y > 3 do.
    gt =: ((3&<)*[:<.@-:2^.]) y NB. if>3, send floor(1/2 * log2(x)) in all directions
    NB. gt =: y > 3
    cn =: y - 4 * gt
    up =.  }. gt , 0            NB. shift in each of the 4 directions
    dn =.  0 , }: gt            NB. (filling in with 0 rather than wrapping)
    lf =.  }."1 gt ,. 0
    rt =.  0 ,. }:"1 gt
    up + dn + lf + rt + cn
  else. y end.
)

1r4 * grid - cn =. 4 | grid      NB. center square keeps only remainder

grid =: i. 16 16
wd'timer 100'
grid
hue =: 31 31 31, 63 255 63, 255 63 63,: 255 255 255
hue =: 180 180 255, 120 120 200, 63 44 93,: 0 0 15
lo =: 16b00000f 16b3f2c5d 16b7878c8 16bc4c4ff   NB. i.4 are shades of blue
hi =: 16bff0000 + 16b001100 * i._16            NB. 4+i.204 are yellow..red
pal =: lo,hi



wd 'pc w closeok; minwh 640 640;'
wd 'pn sandpiles'
wd 'minwh 640 640; cc g isidraw'
wd 'pmove 900 100 0 0 ; pshow'

NB. try running these lines individually after the
NB. timer starts.
grid =: 1250 (<25 25) } 51 51 $ 0

grid =: 1024 (<25 25) } 51 51 $ 0


grid =: 50 50 $ 10
grid =: 50 50 $ 50
grid =: 25 25 $ 51

NB. nice diagonal pattern:
grid =: 500 * =/~i.50

NB. same with two diagonals:
grid =: 124 * (+|.) =/~i.50

NB. how about inverting that?
grid =: 8 * -. (+|.) =/~i.50

NB. higher res with sand to start:
grid =: 4 + -. (+|.) =/~i.100

NB. random grid:
grid =: ? 50 50 $ 10

NB. a sort of siepinski-like triangle:
grid =: (4|[+])/\^:(<@#) 32 # 1

grid =: 1 + grid
grid =: i. 2 2  NB. color palette


grid =: (,|) (,.|) grid

grid =: 1 * 11 = 15 | i. 50 50
grid =: 2 * grid

grid =: 200 (25) } 50 50 $ 2  NB. neat

show =: 3 : 0
  'rgb' vmcc (pal {~ (<:#pal) <.(3+[:<.1.5^.])^:(3&<)"0 y);'g'
)

render =: verb define
  if. 2 = #$ im            NB. only render if im is a 2d array
  do. vmcc im;'g0' end.    NB. (this avoids infinite error boxes)
)


step =: verb define
  grid =: settle grid
  if. 2 = #$ grid            NB. only render if grid is a 2d array
  do.  show  grid end.
)


sys_timer_z_ =: 3 : 'step_base_ 0'

NB. experiment with different speeds:
wd 'timer  0'  NB. use this line to pause
wd 'timer  5'
wd 'timer 10'
wd 'timer 25'
wd 'timer 50'
wd 'timer 100'

NB. start with a sort of circle pattern
NB. this turns out really neat:
show grid =: 9 | >.| j./~i:27

NB. neat + high res but takes long time
NB. show grid =: 9 | >.| j./~i:100

grid =: i. 2 2  NB. color palette
grid =: i. 1 256

load'plot'
grid =: 1024 * = i. 256
wd'sm focus edit' [ 'bar' plot ^.1+ +/|: (i.300)=/255<.,grid
wd'sm focus edit' [ pd'show'
