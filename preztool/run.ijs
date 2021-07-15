NB. Presentation tool for J-Talks video series.
NB. https://www.youtube.com/user/tangentstorm
NB. Available for use under the MIT license.
NB. --------------------------------------------
require'regex'
require'convert/json'
cocurrent'prez'
relpath =: {{ (fpath_j_ jpath>(4!:4<'relpath'){4!:3''),'/',y }}
load relpath 'org.ijs'
load relpath 'jlex.ijs'

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

NB. slide parser -----------------------------------------
NB. slides are stored in *.org files. see org.ijs for the parser.

verb : 0 ''  NB. initialize org_path if it isn't already defined.
  if. -. (<'org_path') e. nl'' do. org_path =: jpath '~JTalks' end.
)

org_path =: wd'mb open1 "Open org file" "',org_path,'" "org (*.org)"'


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

wd'minwh 1284 1080; cc jc webview flush;'
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
       case. ',' do.   NB. w in qwerty: reset windows
         wd'psel jcw; pmove 640 _32 0 0; pshow; ptop;'
         wd'psel tpw; pmove 0 0 0 0;'
       case. '1' do. speed '-1'
       case. '2' do. speed '+1'
       case. '0' do. sho fwd''
       case. '9' do. sho bak''
       fcase. 'R' do. NB. reload html, then fall through to reload slides
         wd 'psel jcw; set jc html *',freads'~JTalks/preztool/jcw.html'
         wd 'psel tpw; set tp html *',freads'~JTalks/preztool/tpw.html'
         position_jterm''
       case. 'r' do. reload_slides''
       case. 'e' do. run_code''
       case. 't' do. position_jterm''
       case. 'T' do.
         NB. full screen terminal in 1080p (leaving room for menu/window top)
         wd 'sm set term xywh -8 0 1920 1046' [ position_jterm''
       case. 'n' do. smoutput names_base_''
       case. 'c' do. clear_base_'' [ wd 'timer 0'
       case. 'd' do.
         NB. dump tokens: one json list per line
         (; LF,~ L:0 <@jsn@code"0 i.#slides) fwrites <'~JTalks/tokens.json'
     end.
  end.
)

(position_jterm =: verb define)''
  NB. This doesn't put the cursor in the right place, so
  NB. just press enter after pressing t.
  wd 'sm set term xywh 0 490 624 554'            NB. bring to front
  wd 'sm set term text *',LF,'  '
  wd 'sm focus term'
)


NB. set up the terminal and editor windows
NB. wd 'sm set term xywh 0 490 620 554'
wd 'sm set term text; sm focus term'           NB. clear terminal
