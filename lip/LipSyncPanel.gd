extends Control

var text : String
var clip : AudioStreamWAV
var player : AnimationPlayer


const temp_animation_name = "rhubarb-temp"

func get_phonemes():
	pass

func build():
	player.remove_animation_library(temp_animation_name)
	var anim = Animation.new()
	player.add_animation_library(temp_animation_name, anim)
