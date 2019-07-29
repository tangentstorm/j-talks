NB. -------------------------------------------
NB.
NB. a simple animation engine for J
NB.
NB. (c) 2019 by michal j wallace
NB.   http://tangentstorm.com/
NB.
NB. free for use under the MIT license.
NB.   https://opensource.org/licenses/MIT
NB.
NB. -------------------------------------------
load 'viewmat'
vmcc =: glpaint_jgl2_@viewmatcc_jviewmat_

NB. -- animation engine ------------------------

im =: 1 (<5 5) } 11 11 $ 0                   NB. init to black grid with one white pixel

update =: ]                                  NB. (override this to mutate the array for animation)

render =: verb define                        NB. draw the grid, avoiding infinite error messages
  if. 2 = #$ im do. vmcc im;'g0' end.
)

step =: render @ update                      NB. each step, we'll call those two in sequence

NB. -- build the window ------------------------

wd 'pc w0 closeok'                           NB. parent control (window) named 'w'.
wd 'pn animation engine'                     NB. give it a title if you want
wd 'minwh 500 500; cc g0 isidraw'            NB. add an 'isidraw' child control named 'g'
wd 'pshow'                                   NB. show the window at the given coordinates.

sys_timer_z_ =: step_base_                   NB. set up global timer to call step
wd 'timer 100'                               NB. start timer at 10 frames per second
