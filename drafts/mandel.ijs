
scale =: 100
area =: |: (i:scale) (j./)&(%&scale)~ -scale-~i.3*scale
step =: ([+*:@])^:(2>|@])"0

load 'viewmat'
viewmat area

p =: |: 0 16b11 0 */ i.16
p viewmat  +/ 2 < | area step^:(<10) area
