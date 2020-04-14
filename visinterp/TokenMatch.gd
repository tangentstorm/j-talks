tool extends ColorRect

const Token = preload("res://Token.tscn")
const JTYPE = preload("res://JTYPE.gd").JTYPE

export var pattern : String = "" setget set_pattern

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
	for node in get_children():
		remove_child(node)
		node.queue_free()
		
	var ty = 5
	var tx = ty
	for c in pattern:
		var t = Token.instance()
		add_child(t)
		t.position.x = tx
		t.position.y = ty
		t.text = c
		t.type = hints.get(c, JTYPE.any)
		tx += max(24, t.get_node("bg").rect_size.x)
		print("c: ",c," tx:",tx)

