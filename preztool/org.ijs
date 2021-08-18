between =: (>:@[ +  i.@<:@-~)/           NB. between 3 7 ->  4 5 6
parse =: monad define
  NB. parse a single slide
  NB. returns (head; text; src) triple
  head =. (2+I.'* 'E.h) }. h=.>{. y      NB. strip any number of leading '*'s, up to ' '
  depth =. h <:@-&# head                 NB. record the number of leading stars
  text =. }. y
  srcd =. '#+begin_src j';'#+end_src'    NB. source code delimiters
  src =: , |: si=.I. y ="1 0 srcd        NB. indices of start and end delimiters
  if. #src do.
    code =. y {~ between 2$src           NB. only take the first source block
    text =. (1{src) }. text
  else. code =. a:  end.
  (<head),(<text),(<code),<depth
)

org_slides =: verb define
  org =. 'b'freads y                     NB. returns a vector of boxed strings
  headbits =. '*' = {.&> org             NB. 1 if org line starts with '*' (a headline)
  slide0 =. headbits <;.1 org            NB. group lines: each headline starts a new slide
  title =: {.org
  slides =: > parse each slide0
)


slide_lines =: {{
  'd h t c' =. (depth;head;text;<@code) y
  r =. <(d#'*'),' ',h
  if. #>c do. r =. r,'#+begin_src j';c,<'#+end_src' end.
  r,t }}

NB. turn the arrays back into org text:
org_text =: {{ ;(,&LF)L:0 title,'';;slide_lines each i.#slides }}

cur=:0
fwd=:verb :'cur=:(<:#slides)<.>:cur'
bak=:verb :'cur=:0>.<:cur'

head =: verb : '> (<y,0) { slides'  NB. -> str
text =: verb : '> (<y,1) { slides'  NB. -> [box(str)]
code =: verb : '> (<y,2) { slides'  NB. -> [box(str)]
depth=: verb : '> (<y,3) { slides'  NB. -> [box(str)]
