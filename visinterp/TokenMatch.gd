@tool extends "AbstractTokenRow.gd"

@export var pattern : String = "" : set = set_pattern

const hints = {
	"E": JTYPE.edge,
	"(": JTYPE.lpar,
	"=": JTYPE.cop,
	")": JTYPE.rpar,
	"I": JTYPE.iden,
	"C": JTYPE.conj,
	"A": JTYPE.adv,
	"V": JTYPE.verb,
	"N": JTYPE.noun,
	"*": JTYPE.any,
	"#": JTYPE.nb
}


func set_pattern(p):
	pattern = p
	clear_tokens()
	for c in pattern:
		add_token(c, hints.get(c, JTYPE.any))

