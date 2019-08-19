NB. Cookbook of interesting arrays
NB. and array transformations for
NB. experimenting with sandpiles.

render =: verb define
  NB. Only render if grid is a 2d array.
  NB. This prevents the IDE from locking with infinite modal
  NB. error messages if you mistakenly set it to a bad value.
  if. 2 = #$ grid do.
    spcc 'spw';'sp';grid
  end.
)

NB. numbers mod 3 ... this shows the grid pretty well
grid =: 3 | i. 50 50

NB. big random grid, like in the original paper:
grid =: 4 + ? 100 100 $ 2



NB. just show the palette:
grid =: i. 2 2
