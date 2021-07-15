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
isSpecial =: [: +./ (1=#) *. 'xymnuv'-:"0 _ {.

jtype =: verb define
  NB. classify a j token
  if. 'NB.' -: 3 {. y do. 'comment'
  elseif. isSpecial y do. 'special'
  elseif. isSpace y  do. 'empty'
  elseif. isCopula y do. 'copula'
  elseif. isCtrl y   do. 'control'
  elseif. isParen y  do. 'paren'
  elseif. 1 do.
    if. isName y do. 'name' return.
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
