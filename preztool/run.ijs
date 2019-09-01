NB. Presentation tool for J-Talks video series.
NB. https://www.youtube.com/user/tangentstorm
NB. Available for use under the MIT license.
NB. --------------------------------------------
require'regex'
require'convert/json'

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

org=:'b'freads'~JTalks/s1e1-sandpiles/sandpiles.org'
sig=:{.&> org
out=:I. '*' = sig
src=:|:>([: I.org=<)&> '#+begin_src j';'#+end_src'



NB. j code window (the "slides") ------------------------

(jcw_close =: verb define)^:(wdisparent'jcw')''
 wd 'psel jcw; pclose;'
)

wd'pc jcw closebutton;'
wd'pn "J-Talks by tangentstorm";'
1920-640
wd'minwh 1280 1080; cc jc webview flush;'
wd'set jc html *',freads'~JTalks/preztool/jcw.html'
wd'pmove 630 _32 0 0; pshow; ptop;'


NB. teleprompter window --------------------------------

(tpw_close =: verb define)^:(wdisparent'tpw')''
 wd 'psel tpw; pclose;'
)
wd'pc tpw closeok;'
wd'minwh 630 440; cc tp webview flush;'
wd'pmove 0 0 0 0; pshow;'



NB. keyboard navigation --------------------------------

cur=:0
fwd=:verb :'cur=:(<:#out)<.>:cur'
bak=:verb :'cur=:0>.<:cur'

txt=:verb define
  (org {~ >:@[ + i.@<:@-~)/ y { src
)

jsn =: verb define
 tok =. (a: = y)  }  |:tok,.<"0 tok =. jlex y
 ('[',']',~]) ','joinstring enc_json L:2 tok
)
sho =: verb define
  wd'cmd jc src *',jsrc =: jsn txt cur
)


jcw_jc_post =: verb define
  smoutput 'name:  ', jc_name
  smoutput 'value: ', jc_value
  select. jc_name
   case. 'init' do. sho''
   case. 'key'  do.
     select. key [ 'key shf ctl alt ' =. ".jc_value
       case. a.i.'0' do. sho fwd''
       case. a.i.'9' do. sho bak''
     end.
  end.
)
