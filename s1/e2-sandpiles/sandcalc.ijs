NB. ------------------------------------------------------------
NB. sandcalc : a sandpile calculator
NB.
NB. (c) copyright 2019 michal j. wallace
NB. http://tangentstorm.com
NB.
NB. available for use under the MIT licence
NB. ------------------------------------------------------------
NB. Quick Sandpile References:
NB. https://en.wikipedia.org/wiki/Abelian_sandpile_model
NB. https://www.youtube.com/watch?v=1MtEUErz7Gg (numberphile)
NB. ------------------------------------------------------------

cocurrent 'sandcalc'
require '~JTalks/s1/e2-sandpiles/sandpiles.ijs'
require '~JTalks/s1/e2-sandpiles/gridpad.ijs'
coinsert 'sandpiles gridpad'

NB. -- main animation logic ---------------------------------

stl =: settle^:_
NxN =: 5 5

NB. "zero": https://hal.archives-ouvertes.fr/hal-00016378
ZSP =: stl (4 - stl) NxN $ 4

pal =: i.4
pen =: 0                        NB. color to draw with
sp0 =: NxN $ 0
sp1 =: NxN $ 3
sp2 =: ZSP

(update =: verb define)''
  sp3 =: stl sp0 + sp1 + sp2
)

render =: verb define
  vmcc sp0;'sp0v'
  vmcc sp1;'sp1v'
  vmcc sp2;'sp2v'
  vmcc sp3;'sp3v'
)


NB. -- build the window -------------------------------------

gpw_opt_title =: 'sandcalc - sandpile calculator'
gpw_opt_timer =: 200
gpw_opt_statusbar =: 0
gpw_opt_colorpick =: 0
gpw_opt_menu =: ''

gpw_init_controls =: verb define
  wd'bin h'
  wd' minwh  50 200; cc palv isigraph;'
  wd' minwh 200 200; cc sp0v isidraw;'
  wd' cc "+" static;'
  wd' minwh 200 200; cc sp1v isidraw;'
  wd' cc "+" static;'
  wd' minwh 200 200; cc sp2v isidraw;'
  wd' cc "=" static;'
  wd' minwh 200 200; cc sp3v isidraw;'
  wd'bin z'
)


NB. -- mouse events -----------------------------------------

gpw_sp0v_mwheel =: gpw_sp1v_mwheel=: gpw_sp2v_mwheel=: gpw_palv_mwheel

NB. left click draws on the input
gpw_sp0v_mblup =: verb : 'sp0 =: sp0 img_draw whichbox 40'
gpw_sp1v_mblup =: verb : 'sp1 =: sp1 img_draw whichbox 40'
gpw_sp2v_mblup =: verb : 'sp2 =: sp2 img_draw whichbox 40'

NB. left drag does the same
gpw_sp0v_mmove =: verb : 'if. mbl _ do. gpw_sp0v_mblup _ end.'
gpw_sp1v_mmove =: verb : 'if. mbl _ do. gpw_sp1v_mblup _ end.'
gpw_sp2v_mmove =: verb : 'if. mbl _ do. gpw_sp2v_mblup _ end.'

NB. right click to copy the sum to an input
gpw_sp0v_mbrup =: verb : 'sp0 =: sp3'
gpw_sp1v_mbrup =: verb : 'sp1 =: sp3'
gpw_sp2v_mbrup =: verb : 'sp2 =: sp3'

NB. middle click to reset the input
gpw_sp0v_mbmup =: verb : 'sp0 =: NxN$0'
gpw_sp1v_mbmup =: verb : 'sp1 =: NxN$3'
gpw_sp2v_mbmup =: verb : 'sp2 =: ZSP'



NB. -- mouse events -----------------------------------------

gpw_init''
