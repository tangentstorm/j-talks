extends Node2D

export var titles = ['']

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var anim
var text

# Called when the node enters the scene tree for the first time.
func _ready():
	text = $"text title"
	anim = $"text title/animation"
	
	anim.play('init')
	yield(anim, "animation_finished")
	
	for t in titles:
		text.text = t
		text.text_len  =0
		anim.play("reveal")
		yield(anim, "animation_finished")
		anim.play('init')
		yield(anim, "animation_finished")
		
	get_tree().quit()


