extends Node2D

const gapw = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	$inputArea.gw = 5
	$inputArea.clear_tokens()
	for tok in $inputBuffer.get_children():
		$inputArea.add_token(tok.text, tok.type)
		$inputArea.size.x = $inputArea.tx

	$stackArea.position.x = $inputArea.position.x + $inputArea.tx + gapw
	$stackArea.size.x = 32

@onready var tween = $Tween
@onready var height = $stackArea.size.y

func ip(node, prop, diff, alen):
	var init = node.get(prop)
	tween.interpolate_property(node, prop,
		init, init+diff, alen,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

var alen = 0.25
var tok

func grab_next_token():
	if tween.is_active(): return
	var ntoks = $inputArea.get_child_count()
	if ntoks == 0: return

	# move token out of input area so it's in front of the stack
	tok = $inputArea.get_child(ntoks-1)
	tok.position += $inputArea.position
	$inputArea.remove_child(tok)
	self.add_child(tok)

	var tokw = tok.size.x
	var reach = gapw + tokw
	ip($stackArea, "size", Vector2(reach, 0), alen)
	ip($stackArea, "position", Vector2(-reach, 0), alen)
	tween.start()
	await tween.tween_all_completed

	# retract the stack
	ip($stackArea, "size", Vector2(-gapw, 0), alen)
	ip($stackArea, "position", Vector2(gapw, 0), alen)
	for child in $stackArea.get_children():
		ip(child, "position", Vector2(tokw,0), alen)

	# move token over to the stack:
	$inputArea.size.x -= tokw
	self.remove_child(tok)
	tok.position -= $stackArea.position
	$stackArea.add_child(tok)
	ip(tok, "position", Vector2(gapw, 0), alen)

	tween.start()
	await tween.tween_all_completed

	$"../pageLabel".text = "ALL DONE!"
	
func move_right():
	if tween.is_active(): return
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()
	if Input.is_key_pressed(KEY_RIGHT):
		ip($stackArea, "size", Vector2(-25,0), alen)
		ip($stackArea, "position", Vector2(50,0), alen)
		tween.start()
	if Input.is_key_pressed(KEY_LEFT):
		grab_next_token()

