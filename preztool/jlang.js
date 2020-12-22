/* J Language Services
 *
 * Provides a lexer for J, and a parser for a subset of J.
 *
 * Basically, this does just enough to provide a data model
 * for some refactoring animations in my videos.
 *
 */


/// Adverbs
let A=[
  '~',   // Reflex • Passive / Evoke
  '/',   // Insert • Table
  '/.',  // Oblique • Key
  '\\',  // Prefix • Infix
  '\\.', // Suffix • Outfix
  '}',   // Item Amend • Amend
  'b.',  // Boolean / Basic
  'f.',  // Fix
  'M.',  // Memo
  't.',  // Taylor Coeff. (m t. u t.)
  't:',  // Weighted Taylor
]

/// Conjunctions
let C = [
  '^:',  // Power (u^:n u^:v)
  '.',   // Determinant • Dot Product
  '..',  // Even
  '.:',  // Odd
  ':',   // Explicit / Monad-Dyad
  ':.',  // Obverse
  '::',  // Adverse
  ';.',  // Cut
  '!.',  // Fit (Customize)
  '!:',  // Foreign
  '"',   // Rank (m"n u"n m"v u"v)
  '`',   // Tie (Gerund)
  '`:',  // Evoke Gerund
  '@',   // Atop
  '@.',  // Agenda
  '@:',  // At
  '&',   // Bond / Compose
  '&.',  // Under (Dual)
  '&.:', // Under (Dual)
  '&:',  // Appose
  'd.',  // Derivative
  'D.',  // Derivative
  'D:',  // Secant Slope
  'H.',  // Hypergeometric
  'L:',  // Level At
  'S:',  // Spread
  'T.',  // Taylor Approximation
];

/// Verbs
let V = [
  '=',    // Self-Classify • Equal
  '<',    // Box • Less Than
  '<.',   // Floor • Lesser Of (Min)
  '<:',   // Decrement • Less Or Equal
  '>',    // Open • Larger Than
  '>.',   // Ceiling • Larger of (Max)
  '>:',   // Increment • Larger Or Equal
  '_:',   // Infinity
  '+',    // Conjugate • Plus
  '+.',   // Real / Imaginary • GCD (Or)
  '+:',   // Double • Not-Or
  '*',    // Signum • Times
  '*.',   // Length/Angle • LCM (And)
  '*:',   // Square • Not-And
  '-',    // Negate • Minus
  '-.',   // Not • Less
  '-:',   // Halve • Match
  '%',    // Reciprocal • Divide
  '%.',   // Matrix Inverse • Matrix Divide
  '%:',   // Square Root • Root
  '^',    // Exponential • Power
  '^.',   // Natural Log • Logarithm
  '$',    // Shape Of • Shape
  '$.',   // Sparse
  '$:',   // Self-Reference
  '~.',   // Nub •
  '~:',   // Nub Sieve • Not-Equal
  '|',    // Magnitude • Residue
  '|.',   // Reverse • Rotate (Shift)
  '|:',   // Transpose
  ',',    // Ravel • Append
  ',.',   // Ravel Items • Stitch
  ',:',   // Itemize • Laminate
  ';',    // Raze • Link
  ';:',   // Words • Sequential Machine
  '#',    // Tally • Copy
  '#.',   // Base 2 • Base
  '#:',   // Antibase 2 • Antibase
  '!',    // Factorial • Out Of
  '/:',   // Grade Up • Sort
  '\\:',   // Grade Down • Sort
  '[',    // Same • Left
  '[:',   // Cap
  ']',    // Same • Right
  '{',    // Catalogue • From
  '{.',   // Head • Take
  '{:',   // Tail •
  '{::',  //  Map • Fetch
  '}.',   // Behead • Drop
  '}:',   // Curtail •
  '".',   // Do • Numbers
  '":',   // Default Format • Format
  '?',    // Roll • Deal
  '?.',   // Roll • Deal (fixed seed)
  'A.',   // Anagram Index • Anagram
  'C.',   // Cycle-Direct • Permute
  'e.',   // Raze In • Member (In)
  'E.',   // • Member of Interval
  'i.',   // Integers • Index Of
  'i:',   // Steps • Index Of Last
  'I.',   // Indices • Interval Index
  'j.',   // Imaginary • Complex
  'L.',   // Level Of •
  'o.',   // Pi Times • Circle Function
  'p.',   // Roots • Polynomial
  'p..',  // Poly. Deriv. • Poly. Integral
  'p:',   // Primes
  'q:',   // Prime Factors • Prime Exponents
  'r.',   // Angle • Polar
  's:',   // Symbol,
  'u:',   // Unicode,
  'x:',   // Extended Precision
  '_9:',' _8:','_7:','_6:','_5:','_4:','_3:','_2:','_1:','0:',
  '9:',  '8:', '7:', '6:', '5:', '4:', '3:', '2:', '1:', //  Constant Functions
];

// tokenize j code (str -> toks)
const JTYPES = ['nb',   'xyn',            'num','num','num','num',   'str',    'par', 'ws', 'op',                               'ctl',   'idn']
const JLEXRE = /(NB.*$)|(a[.:]|[xyuvn]\b)|((_|_?\d+)(\s+(_|_?\d+))*)|('[^']*')|([()])|(\s+)|([^ ][.:]+|-|\[|]|[_,"+*<$>&^@{:}=])|(\w+[.])|(\w+)/g
const JKIND = {
  '=:': 'cop', // is (global)
  '=.': 'cop', // is (local)
  '_.': 'num', // indeterminate
  'a.': 'L', // alphabet
  'a:': 'y', // it's a boxed noun.
}
// register primitives from jlang.js:
V.forEach(x => JKIND[x] = 'V')
C.forEach(x => JKIND[x] = 'C')
A.forEach(x => JKIND[x] = 'A')

function* jlex(src) {
  for (let m of src.matchAll(JLEXRE)) {
    let tok = m.shift()
    let typ = JTYPES[m.indexOf(tok)]
    if (typ === 'op') typ = JKIND[tok];
    yield [typ, tok] }}


// token type: {
//   a: 1 (indicates atom in AST)
//   k: kind (from JKIND, used for css styling)
//   t: text of the token
//   p: part of speech (if applicable)

function jPartOfSpeech(tok) {
  switch (tok.k) {
    case 'A': case 'V': case 'N': case 'C': return tok.k
    case 'cop': return '='
    case 'str': return 'N'
    case 'num': return 'N'
    case 'xyn': return 'xynm'.includes(tok.t) ? 'N' : 'V'  // !! is this always true?
    case 'par': return tok.t==='(' ? 'L' : 'R'
    case 'idn': return 'I'
    default: return ''}}

/// Extends jlex to provide a list of token objects grouped by line
function jTokens(src) {
  // one object per lexeme, grouped by line:
  let tokls = src.split("\n").map(x=>[...jlex(x)].map(tok=>({a:1, k:tok[0], t:tok[1]})))
  // annotate with text coordinates:
  for (let y=0; y<tokls.length; y++) { let x=0
    for (let tok of tokls[y]) { tok.x=x; tok.y=y; x+=tok.t.length; tok.p = jPartOfSpeech(tok)}}
  return tokls}


// node type: {
///  a: 0 (indicating not an atom)
//   r: grammar rule
//   p: part of speech (CAVN)
//   d: definitions
//   c: children }
function jNode(r, p, d, c) { return {a:0, r, p, d, c}}


/// shorthand constructor for jNode from 'res' in jStmt
function jN(pos, len, r, p, d, c) { this.splice(pos,len,jNode(r,p,d,c)) }

// J Parsing and Evaluation Rules
// https://www.jsoftware.com/help/dictionary/dicte.htm
function r0Monad(_,v,n)  { jN.call(this, 1, 2, 'mo', 'N', {}, [v,n]) }
function r1Monad(_,u,v,n){ jN.call(this, 2, 2, 'mo', 'N', {}, [v, n]);
                           r0Monad.apply(this, this) }
function r2Dyad(_,x,v,y) { jN.call(this, 1, 3, 'dy', 'N', {}, [x, v, y]) }
function r3Adverb(_,vn,a){ jN.call(this, 1, 2, 'ad', vn.p, {}, [vn, a]) }   // TODO: deduce true part of speech
function r4Conj(_,m,c,n) { jN.call(this, 1, 3, 'cn', 'V', {}, [m, c, n]) }  // TODO: deduce true part of speech
function r5Fork(_,m,u,v,){ jN.call(this, 1, 3, 'fk', 'V', {}, [m, u, v])}
function r6Bident(_,x,y) { jN.call(this, 1, 2, 'bi', 'V', {}, [x, y]) }     // TODO: deduce true part of speech
function r7Is(i,o,e)     { jN.call(this, 0, 3, 'is', e.p, {}, [i,o,e]) }
function r8Paren(){ return this } // TODO
// The documentation link above doesn't yet include a rule for direct definition, but it's obvious enough.
// https://code.jsoftware.com/wiki/Vocabulary/DirectDefinition
// note that i'm working with a single line at a time so this can't yet parse multi-line direct defs
function r9Direct(){ return this } // TODO

const rules = [
  // 'M' = mark (start of input)
  // '=' assignment token (=. or =:)
  // 'L'..'R'  = parens '('..')'
  // 'l'..'r'   = direct definition '{{' .. '}}'
  // 'A' = adverb
  // 'C' = conjunction
  // 'N' = noun
  // 'V' = verb
  // 'I' = iden
  [/[M=L]VN./,  r0Monad],
  [/[M=LAVN]VVN/, r1Monad],
  [/[M=LAVN]NVN/, r2Dyad],
  [/[M=LAVN]A./,  r3Adverb],
  [/[M=LAVN][VN]C[VN]/, r4Conj],
  [/[M=LAVN][VN]V/, r5Fork],
  [/[M=L][CAVN][CAVN]./, r6Bident],
  [/[IN]=[CAVN]./, r7Is],
  [/L[CAVN]R./, r8Paren],
  [/l[CAVN]r./, r9Direct]]

/// parse a single line of tokens into an AST node
function jStmt(tokl, scope) {
  let d = {}, res = [], tl=tokl.length
  if (tl && tokl[tl-1].k === 'nb') { d.nb = tokl.pop() }
  let state = '', toks = [{p:'M'}].concat(tokl.filter(t=>t.k !== 'ws'))
  while ((tl = toks.length)) {
    let tok = toks.pop(); res.unshift(tok)
    if (tok.p==='I') tok.p = scope[tok.t] || 'I' // attempt to resolve identifiers to part of speech
    // if (res.length===1 || res[1].k!=='cop') console.log(`${tok.t} pos: ${tok.p}`)
    state = res.map(x => x.p).join('') + '..'
    // console.log(state)
    for (let i=0; i<rules.length; i++) if (state.match(rules[i][0])) {
      // console.log(`MATCHED RULE ${i}`)
      rules[i][1].apply(res, res)
      if (res[0].r === 'is') scope[res[0].c[0].t] = res[0].c[2].p // remember part of speech on assignment
      break }}
  if (res[0].p === "M") res.shift();
  else if (toks.length){ console.warn(['expected to be at left edge!', res])}
  return jNode('stmt', '', d, res)}

/// given a 2d list of tokens (token lines), build an AST
function jParse(tokls) {
  let ln = 0, res = [], scope={} // TODO: properly handle global vs local scope
  while (ln<tokls.length) {
    let tokl = tokls[ln], stmt = jStmt(tokl, scope)
    // TODO: do a complete analysis for (:0) to find any explicit definition (including nouns or more than one)
    if (tokl.some(tok=> tok.t === 'define')) {
      let suite = []
      while(++ln<tokls.length) {
        tokl = tokls[ln]
        if (tokl.length && tokl[0].t === ')') break;
        else suite.push(jStmt(tokl, scope)) }
      res.push(jNode('suite', '', {}, [stmt, ...suite])) }
    else res.push(stmt)
    ln++ }
  return jNode('jlang', '', {}, res)}

// walk the node and collect definitions in the .d slot of each node
function jFindDefs(node) {
  if (node.r === 'is') {
    let [lhs, op, rhs] = node.c
    if (lhs.k === 'str') console.warn("unhandled: 'a b c'=: 1 2 3"); // TODO
    else {
      let n = op.t === '=.' ? '.' + lhs.t : lhs.t
      // !! This creates a circular data structure, but it lets us
      //    keep the whole definition (both right and left sides).
      //    Maybe move this up one level so the 'is' note doesn't
      //    contain a reference to itself?
      node.d[n] = node }}
  else if (node.a) {} // no change for atoms
  else if (!node.c) { console.log('no .c found in node:'); console.log(node)}
  else for (let c of node.c) Object.assign(node.d, jFindDefs(c).d)
  return node}

/// Given an AST node, recover the original source code
/// as a single string. (mostly for debugging)
// TODO: re-insert comments
function jDumpAST(node) {
  let res = {txt:[], sx:0, sy:-1}
  function f(node, res) {
    if (node.a) {
      if (res.sy===-1) res.sy=node.y
      else while (node.y > res.sy) { res.txt.push('\n'); res.sy++; res.sx=0 }
      while (node.x > res.sx) { res.txt.push(' '); res.sx++ }
      res.txt.push(node.t); res.sx += node.t.length }
    else for (let c of node.c) f(c, res)}
  f(node, res); return res.txt.join('')}

/// Given an AST node, return the (non-whitespace, non-comment) tokens as 1d array
function jFlattenAST(node) {
  let toks = []; function f(n) { n.a ? toks.push(n): n.c.forEach(f) }
  f(node); return toks }
