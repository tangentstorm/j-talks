NB. Sandpiles were originally used as a simulation in the paper
NB. "Self-organized criticality: an explanation of 1/f noise"
NB. by Per Bak, Chao Tang and Kurt Wiesenfeld

grid =: 4 + ?100 100 $ 4
wd 'timer 1'
grid =: 4 (<? 100 100) } grid0 =: grid
viewmat grid0 ~: grid