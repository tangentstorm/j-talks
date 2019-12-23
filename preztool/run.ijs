NB. Presentation tool for J-Talks video series.
NB. https://www.youtube.com/user/tangentstorm
NB. Available for use under the MIT license.
NB. --------------------------------------------
require'regex'
require'convert/json'

cocurrent'prez'

smoutput help =: noun define
This utility opens two windows, both generated from the same *.org file.
The keyboard controls both windows, and the keys work regardless of
which window is focused.

  j code window  (jcw.html, shows highlighted j code)
  -------------
  0 next slide
  1 previous slide
  e execute code on this slide

  prompter window  (tpw.html, shows text from the org file)
  ---------------
  ` freeze
  1 slow down
  2 speed up

  general
  -------
  r reload slides and text for current file

In the org file, each block of code should have its own header.
)

NB. j syntax highlighting ------------------------------

jtoks =: verb define
  NB. tokenize j like ;: but include whitespace
  r =. 0$a:
  for_t. ;: y do.                  NB. for each token
    if. p =. {. (>t) ss y do.      NB. if there's whitespace before first match
      'w y' =. p ({. ; }.) y       NB. shift prefix into w
      r =. r, <w                   NB. and append to tokens
    end.
    r =. r,t
    y =. (#>t)}.y                  NB. drop token from y
  end.
  if. #y do. r =. r,<y end.        NB. append final whitespace
  r
)

NB. helpers for jtyp
isName =: [: # '^[[:alpha:]]\w+$' & rxmatches
reCtrl =: '^(assert|break|continue|(goto|label|for)(_\w+)|do|end|if|else|elseif|return'
reCtrl =: reCtrl,'|select|f?case|throw|while|whilst)[.]'
isCtrl =: [: #  reCtrl & rxmatches
isCopula =: [: # '=[.:]' & rxmatches
isParen =: (1=#) *. [: +./@, '()' -:"0 {.
isSpace =: [:*./' '=]

jtype =: verb define
  NB. classify a j token
  if. 'NB.' -: 3 {. y do. 'comment'
  elseif. isSpace y  do. 'empty'
  elseif. isCopula y do. 'copula'
  elseif. isCtrl y   do. 'control'
  elseif. isParen y  do. 'paren'
  elseif. 1 do.
    if. isName y do. 'name' return.9
      v=.".y
      t=.>type<'v'
    else. try. t=.>type<'v'[".'v=. ',y catch. 'invalid' return. end. end.
    if. t -: 'noun' do. datatype v
    elseif. t -: 'not defined' do. 'undefined'
    elseif. t -: 'floating' do. 'float'
    elseif. 1 do. t end.
  end.
)

jlex =: verb def '(jtype;]) L:0 jtoks each ,. y'


NB. org file parser -------------------------------------

verb : 0 ''  NB. initialize org_path if it isn't already defined.
  if. -. (<'org_path') e. nl'' do. org_path =: jpath '~JTalks' end.
)

org_path =: wd'mb open1 "Open org file" "',org_path,'" "org (*.org)"'

between =: (>:@[ +  i.@<:@-~)/           NB. between 3 7 ->  4 5 6
parse =: monad define
  NB. parse a single slide
  NB. returns (head; text; src) triple
  head =. (2+I.'* 'E.h) }. h=.>{. y      NB. strip any number of leading '*'s, up to ' '
  text =. }. y
  srcd =. '#+begin_src j';'#+end_src'    NB. source code delimiters
  src =: , |: I. y ="1 0 srcd            NB. indices of start and end delimiters
  if. #src do.
     code =. y {~ between 2$src          NB. only take the first source block
     text =. text -. code, srcd
  else.
     code =. a:
  end.
  (<head),(<text),(<code)
)

load_slides =: verb define
  org =. 'b'freads org_path              NB. returns a vector of boxed strings
  headbits =. '*' = {.&> org             NB. 1 if org line starts with '*' (a headline)
  slide0 =. headbits <;.1 org            NB. group lines: each headline starts a new slide
  slides =: > parse each slide0
)

load_slides''



NB. j code window (the "slides") ------------------------

(jcw_close =: verb define)^:(wdisparent'jcw')''
 wd 'psel jcw; pclose;'
)

wd'pc jcw closebutton;'
wd'pn "J-Talks by tangentstorm";'

wd'minwh 1280 1080; cc jc webview flush;'
wd'set jc html *',freads'~JTalks/preztool/jcw.html'
wd'pmove 630 _32 0 0; pshow; ptop;'


NB. teleprompter window --------------------------------

(tpw_close =: verb define)^:(wdisparent'tpw')''
 wd 'psel tpw; pclose;'
)
wd'pc tpw closeok;'
wd'minwh 630 440; cc tp webview flush;'
wd'set tp html *',freads'~JTalks/preztool/tpw.html'
wd'pmove 0 0 0 0; pshow;'



NB. keyboard navigation --------------------------------
NB. same keys work in both windows so i don't have to think about window focus.

cur=:0
fwd=:verb :'cur=:(<:#slides)<.>:cur'
bak=:verb :'cur=:0>.<:cur'

head =: verb : '> (<y,0) { slides'  NB. -> str
text =: verb : '> (<y,1) { slides'  NB. -> [box(str)]
code =: verb : '> (<y,2) { slides'  NB. -> [box(str)]


jsn =: verb define
 NB. generate json for highlighted source code
 if. y -: a: do. '[]' return. end.
 tok =. (a: = y)  }  |:tok,.<"0 tok =. jlex y
 ('[',']',~]) ','joinstring enc_json L:2 tok
)

sho =: verb define
  NB. show the headline, code, and teleprompter text
  wd'psel jcw'
  wd'cmd jc head *',enc_json head cur
  wd'cmd jc src *',jsrc =: jsn code cur
  wd'psel tpw'
  wd'cmd tp txt *',txt =: enc_json text cur
)

speed =: verb define
  NB. set speed of the prompter
  wd'psel tpw'
  wd'cmd tp spd ',":y
)

jcw_jc_post =: verb define
  NB. pass messages from the code window's web control to on_event
  jc_name on_event jc_value
)

tpw_tp_post =: verb define
  NB. pass messages from the prompter's web control to on_event
  tp_name on_event tp_value
)

reload_slides =: verb define
  sho cur [ load_slides 0
)

run_code =: verb define
  NB. immediately execute the j code from the current slide
  immexj LF joinstring code cur
)

on_event =: dyad define
  NB. smoutput 'name:  ', x
  NB. smoutput 'value: ', y
  select. x
   case. 'init' do. sho''
   case. 'key'  do.
     select. key=. a. {~ {. 'key shf ctl alt ' =. ".YY=:y
       case. '`' do. speed 0
       case. '1' do. speed '-1'
       case. '2' do. speed '+1'
       case. '0' do. sho fwd''
       case. '9' do. sho bak''
       case. 'r' do. reload_slides''
       case. 'e' do. run_code''
       case. 't' do.
         NB. It doesn't put the cursor in the right place, so
         NB. just press enter after pressing t.
         wd 'sm set term xywh 0 490 620 554'            NB. bring to front
         wd 'sm set term text *',LF,'  '
         wd 'sm focus term'
       case. 'n' do. smoutput names_base_''
       case. 'c' do. clear_base_'' [ wd 'timer 0'
     end.
  end.
)

NB. set up the terminal and editor windows
NB. wd 'sm set term xywh 0 490 620 554'
wd 'sm set term text; sm focus term'           NB. clear terminal
