load 'viewmat'
vmcc =: glpaint_jgl2_@viewmatcc_jviewmat_

NB. for faster toppling, try this line.  (not 100% sure you get same results...)
NB. gt =: ((3&<)*[:<.@-:2^.]) y NB. if>3, send floor(1/2 * log2(x)) in all directions

settle =: monad define          NB. recursively settle sandpiles with entries > 3
  if. # I. , y > 3 do.
    gt =: y > 3
    cn =: y - 4 * gt
    up =.  }. gt , 0            NB. shift in each of the 4 directions
    dn =.  0 , }: gt            NB. (filling in with 0 rather than wrapping)
    lf =.  }."1 gt ,. 0
    rt =.  0 ,. }:"1 gt
    up + dn + lf + rt + cn
  else. y end.
)

grid =: i. 16 16

lo =: 16b00000f 16b3f2c5d 16b7878c8 16bc4c4ff   NB. i.4 are shades of blue
hi =: 16bff0000 + 16b001100 * i._16             NB. yellow..red gradient
pal =: lo,hi
'rgb'viewmat ,.pal


wd 'pc w0 closeok; minwh 640 640;'
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
  wd'psel w0'
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
