NB. collatz conjecture binary tree
NB. we'll make a complete binary tree out to depth N ((2^N)-1 entries)
NB. array is stored in a flat array with implicit parent-child relationships

] N =: 7                           NB. total depth of the tree
] L =: <:2^N                       NB. length of the array (could also add one extra slot at end so tables look ok)
] A =: i.L                         NB. array index (count from 1 to 2^N)
] I =: 1 + A                       NB. index starting at 1 to simplifies D and P calcs
] IN =: (<:2^N-1)$I                NB. the interior (non-leaf) nodes
] LO =: 0 2 p. IN                  NB. low child for index i is 2i+0
] HI =: 1 2 p. IN                  NB. high child for index i is 2i +1
] UP =: <.-:I
] D =: <.2^. I                     NB. depth of each node
] P =: D (-@[ <@|.@{. #:@])"0 I    NB. path to reach this node from the root.
                                   NB. (strip highest 1 bit from L, reverse lower bits)
                                   NB. (we know the highest 1 bit from the depth)

] T =: ,~<.%:2^N                   NB. shape of table

T $ D
T $ LO,(>:2^N-1)$_                 NB. map of lo children
T $ HI,(>:2^N-1)$_                 NB. map of hi children

'01' {~ L:0 T $ P                  NB. draw paths a big table
'01' {~ L:0 T $ <"1 #: i.2^N       NB. compare to just counting to 2^N


NB. todo: function to propagate value from root to children

lo =: 1 2 & p.
hi =: 2 2 & p.
walk =: {{
  NB. depth first walk of a flat binary tree.
  NB. (breadth first is just for_i. #tree do.)
  u y
  if. x > 0 do.
    (x-1) u walk lo y
    (x-1) u walk hi y
  end. }}

5 smoutput walk 0


NB. -- building an array like this ---


build =: {{
  NB. (x=:depth) u build (y=:init)  -> array of shape (<:2^x),$y
  NB. (x=:bit) u y  -> new value, modifying y by some bit
  r =. ,: y
  for_i. 1+i.<:<:2^x do.
    up =. <.-:<:i   
    r =. r, (-.2|i) u up{r
  end.
  r }}

NB. this is how the low/hi branch indices are calculated.
branch =: {{ if. x do. 2 2 p. y else. 1 2 p. y end. }} 

NB. so this should build a tree mapping each index to itself:
assert (i.<:2^4) -: 4 branch build 0

NB. here is the collatz tree
[ POL =: N {{ if. x do. 1 0 + 3 * y else. -: y end. }} build 0 1x

NB. intercepts with  f(n)=n
[ INT =: {{ b % d-mx ['b mx' =. y * d=. %+./y }}"1 POL
[ INT =:  _:^:(~:<.)"0 INT


NB. --- graphviz -----------------


[ gold =: I. INT e. ] 0, 1 2 4, _1 _2, _5 _14 _7 _20 _10


s =. {{
  r=.'n',(":y),'[label="',(":(<:y){INT),'\n',(":(<:y){POL),'"'
  if. (<:y) e. gold do. r =. r,';fillcolor=gold' end.
  r=. r, ']'
  r }}"0 I
s =. s, 'n',"1 (":"0 IN),. ' -> n',"1  (":"0 LO),"1 '[style=dashed]'
s =. s, 'n',"1 (":"0 IN),. ' -> n',"1  ":"0 HI
s =. (';',CRLF) joinstring ;/s
s =. 'digraph { bgcolor="#193549"; node[shape=box;style=filled;fillcolor="#eeeeee"]; ',s,' }'
s
s fwrites<'d:/ver/j-talks/wip/collatz/graph.dot'


NB. --- collatz application ------

E =:  (2^D) ([ <@,"0 |)I           NB. equivalance classes for collatz conjecture
T $ E
T $ <__ NB. blank slate


NB. todo: (collatz): build the polynomial trees (can be done all at once, or with tree walk)
NB. todo: (collatz): find the intercept with f(x)=x  (can be done all at once)
NB. todo: (collatz): handle the
NB. todo: (collatz): sparse array version


NB. --- heap operations ----------

NB. todo: tree operations (esp for binheap)

