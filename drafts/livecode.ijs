NB. livecoding playground for J

load 'viewmat'

NB. (expose viewmatcc)
vmcc =: glpaint_jgl2_@viewmatcc_jviewmat_


wd 'sm set term xywh 0 490 640 554'
wd 'sm set edit xywh 645 5 1262 1038'
wd 'sm focus term'                  NB. session manager: bring terminal to front

wd 'pc w0 closeok'                   NB. parent control (window) named 'w'.
wd 'minwh 500 500; cc g0 isidraw'    NB. add an 'isidraw' child control named 'g'
wd 'pshow; pmove 40 510 0 0'        NB. show the window at the given coordinates.
wd 'psel w0'                         NB. select our window
wd 'ptop'                           NB. move our window to the front
 
im =: 10 10 $ 0

render =: verb define
  if. 2 = #$ im do. vmcc im;'g0' end.
)

step =: render [ update
sys_timer_z_ =: step_base_

wd 'timer 100'

NB. some nice arrays to look at.
im =: ? 10 10 $ 2            NB. random black/white pattern
im =: ? 100 100 $ 2          NB. higher resolution
im =: i. 10 10               NB. count to 100
im =: i. 2 2                 NB. a simple 4-square
im =: j./~ i:10              NB. the complex plane, near the origin
im =: |j./~ i:10             NB. magnitudes from the center
im =: 10 10 $ 1              NB. pure white
im =: 1 (<5 5) } 11 11 $ 0   NB. one white pixel in the middle
im =: ~:/\^:(<@#) 8 # 1      NB. mysterious triangle??

NB. operators on the current pattern:
im =: im * i.$im             NB. rainbowfy a black and white image
im =: 2 | im                 NB. reduce color to black and white (using mod 2)
im =: |: im                  NB. transpose
im =: |. im                  NB. flip top to bottom
im =: |."1 im                NB. flip left to right
im =: |: |. im               NB. rotate 90 degrees
im =: |. |: im               NB. rotate the other way
im =: -. im                  NB. flip the bits
im =: ,~ ,.~ im              NB. split into four copies
im =: (,|.) (,. |."1) im     NB. four copies, but mirrored across each axis
im =:  1 |. im               NB. rotate up (top row moves to bottom)
im =: _1 |. im               NB. rotate down
im =:  1 |."1 im             NB. rotate left
im =: _1 |."1 im             NB. rotate right
im =: }. im , 0              NB. shift up, pad with 0
im =: 0 , }: im              NB. shift down, pad with 0
im =: }."1 im ,. 0           NB. shift left, pad with 0
im =: 0 ,. }:"1 im           NB. shift right, pad with 0

NB. some update strategies:
update =: verb def 'im =: 10 | im + 1'   NB. rotate the palette
update =: ]                              NB. do nothing
