NB. representation is as list of coordinates

k1 =: ,. 0j0  NB. monomino: a single tile at (0,0)
dirs =: (,-) 1 0j1

NB.
dirs (],"1 +/)"1^:2 k1

shift =: {{ (+|@(<./@,))"2 dirs (,/"_ 1 ~.@,/@(+"1/)) y}}

dirs (,"2/ ~.@,/@(+"1/)) k1
$k1+/dirs
$k1
draw =: {{ x {{1 y}(,~x)$0}} each <"1^:2 y }}

shift k1

2 draw shift k1

shift shift k1