extends Node

func _process(dt: float):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()
	if Input.is_key_pressed(KEY_RIGHT):
		$TokenLine.move_right()
	if Input.is_key_pressed(KEY_LEFT):
		$TokenLine.grab_next_token()

	if Input.is_key_pressed(KEY_COMMA):
		$MatchSlider.slide(0,-10)
	if Input.is_key_pressed(KEY_O):
		$MatchSlider.slide(0,10)
	if Input.is_key_pressed(KEY_A):
		$MatchSlider.slide(-10,0)
	if Input.is_key_pressed(KEY_E):
		$MatchSlider.slide(10,0)
