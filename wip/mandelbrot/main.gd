extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func toggle(object):
	object.visible = not object.visible


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_per_pixel_transparency_enabled = true 
	get_tree().get_root().set_transparent_background(true)
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_just_pressed("toggle1"):
		toggle($"viewmat")
	if Input.is_action_just_pressed("toggle2"):
		toggle($"complexplane")
	if Input.is_action_just_pressed("toggle3"):
		toggle($"mandelbrot")
	if Input.is_action_just_pressed("toggle4"):
		toggle($"gradient")
