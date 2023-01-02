NB. collatz search algorithm
clear''

C =: -:`(1 3 & p.)@.(2&|)                 NB. original collatz function
T =: -:`(1r2 3r2 & p.)@.(2&|)             NB. collatz with odd = (1+3n)/2
CDE =: C^:(~:1:)^:a:                       NB. descent (C)
CGL =: {{ C^:(x&<: *. 1&~:)^:(a:) y }}"0~  NB. glide (C)
DE =: T^:(~:1:)^:a:                        NB. descent (T)
GL =: {{ T^:(x&<: *. 1&~:)^:(a:) y }}"0~   NB. glide (T)
G  =: <:@#@GL

NB. polynomial versions

Sp =: 1+3&*            NB. scale
Rp =: -:               NB. reduce
Cp =: R`S@.(2&|)"0     NB. collatz step
Tp =: R@(S^:(2&|))"0   NB. bake in the division
Np =: 2                NB. bits per state
Mp =: 2                NB. bits per token

'n2 m2' =: 2^N,M
s =: (n2*m2)$i.n2     NB. states per token
t =: n2#i.m2          NB. tokens per state
x0 =: s + t * n2      NB. init value
cx =: C x0            NB. just for reference
x1 =: T x0            NB. done value
s0 =: n2 | x0         NB. init state
s1 =: n2 | x1         NB. done state

NB. display as table:
(;:,:(,.@".&.>)@;:) 't s x0 cx x1 s0 s1'

/:~~.s0,.s1           NB. unique state transitions
