const expect = chai.expect

describe("jTokens", ()=>{

  it('should tokenize simple expressions', ()=>{
    let tokls = jTokens('2+2')
    expect(tokls.length).to.equal(1) // 1 line
    expect(tokls[0].length).to.equal(3) // 3 tokens
  })})


describe("jStmt", ()=>{

  it('should parse a single line of j code', ()=>{
    let ast = jStmt(jTokens('b =: i. a =: 2+2 NB. nota bene')[0])
    expect(ast.r).to.equal('stmt')
    expect(ast.d.nb.t).to.equal('NB. nota bene')
    expect(ast.c.length).to.equal(1)
  })

})
