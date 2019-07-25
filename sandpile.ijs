load 'viewmat'
require '~/ver/j-talks/vmcc.ijs'

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
  if. # I. , gt =. y > 3 do.
    up =.  }. gt , 0            NB. shift in each of the 4 directions
    dn =.  0 , }: gt            NB. (filling in with 0 rather than wrapping)
    lf =.  }."1 gt ,. 0
    rt =.  0 ,. }:"1 gt
    up + dn + lf + rt + y - gt * 4
  else. y end.
)

hue =: 31 31 31, 63 255 63, 255 63 63,: 255 255 255
hue =: 255 255 255, 120 120 200, 63 299 93,: 31 31 31


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
  hue vmcc y;'g'
)

step =: verb define
  grid =: settle grid
  show 3 <. grid
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
