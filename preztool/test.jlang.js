const expect = chai.expect

describe("jTokens", ()=>{

  it('should tokenize simple expressions', ()=>{
    let tokls = jTokens('2+2')
    // 1 line, 3 tokens:
    expect(tokls.length).to.equal(1)
    expect(tokls[0].length).to.equal(3) })})


describe("jStmt", ()=>{

  it('should parse a single line of j code', ()=>{
    let ast = jStmt(jTokens('b =: i. a =: 2+2 NB. nota bene')[0])
    expect(ast.r).to.equal('stmt')
    expect(ast.d.nb.t).to.equal('NB. nota bene')
    expect(ast.c.length).to.equal(1) })})

let SRC0 =`\
a =: 0  NB. node 0 (stmt)
b =: monad define  NB. node 1 (suite)
  b1 =. 10
  b2 =. 11
)
c =: 2 NB. node 2 (stmt)`

describe("jParse", ()=>{
  it("should group multi-line definitions into suites", ()=>{
    let ast = jParse(jTokens(SRC0))
    expect(ast.r).to.equal('jlang')
    expect(ast.c.length).to.equal(3)
    expect(ast.c.map(n=>n.r)).to.eql(['stmt','suite','stmt'])
    expect(ast.c[1].d.suite.map(n=>n.r)).to.eql(['stmt','stmt']) })})
