extends Node2D

func toggle(node_name):
	var object = find_child(node_name)
	if object == null:
		print("not found:", node_name)
		return
	object.visible = not object.visible

func _ready():
	OS.window_per_pixel_transparency_enabled = true 
	get_tree().get_root().set_transparent_background(true)

func _process(_delta):
	if Input.is_action_just_pressed("toggle1"):
		toggle("viewmat")
	if Input.is_action_just_pressed("toggle2"):
		toggle("complexplane")
	if Input.is_action_just_pressed("toggle3"):
		toggle("mandelbrot")
	if Input.is_action_just_pressed("toggle4"):
		toggle("gradient")
