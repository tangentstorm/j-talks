# AbstractTokenRow: abstract row of J Tokens with a colored background.

extends ColorRect

const Token = preload("res://visinterp/Token.tscn")
const JTYPE = preload("res://visinterp/JTYPE.gd").JTYPE

var gw = 0
var ty = 5
var tx = ty

func clear_tokens():
	tx = ty
	for node in get_children():
		remove_child(node)
		node.queue_free()

func add_token(text, type):
	var t = Token.instance()
	add_child(t)
	t.rect_position.x = tx
	t.rect_position.y = ty
	t.text = text
	t.type = type
	tx += max(24, t.rect_size.x) + gw
	if is_inside_tree():
		t.set_owner(get_tree().edited_scene_root)
