extends Control

var text : String
var clip : AudioStreamSample
var player : AnimationPlayer


const temp_animation_name = "rhubarb-temp"

func get_phonemes():
	pass

func build():
	player.remove_animation(temp_animation_name)
	var anim = Animation.new()
	player.add_animation(temp_animation_name, anim)
