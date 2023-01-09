extends AnimationPlayer

	
func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		play("lipsync.000")
		queue('blink')
		queue("eyebrow-raise")
		queue("lipsync.001")
