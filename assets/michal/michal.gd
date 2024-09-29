@tool extends Node2D

@onready var brow_node = $"neck/head/brow"
@onready var mouth_node = $"neck/head/mouth"
@onready var eyes_node = $"neck/head/eyes"
@onready var head_node = $"neck/head"
@onready var body_node = $"body"

@export_enum("A","B","C","D","E","F","G","H","X") var mouth : String = "X" :
	set(x):
		mouth = x
		if mouth_node: mouth_node.frame = "ABCDEFGHX".find(x)

enum EyeSprite { LEFT, CENTER, RIGHT, CLOSED }
@export var eyes : EyeSprite = EyeSprite.CENTER :
	set(x): eyes = x; if eyes_node: eyes_node.frame = EyeSprite.get(x)

enum BrowSprite { LEFT, UP, DOWN, NEUTRAL }
@export var brow : BrowSprite = BrowSprite.NEUTRAL :
	set(x): brow = x; if brow_node: brow_node.frame = BrowSprite.get(x)

enum ShoulderPosition { R, U, L, D }
@export var shoulders : ShoulderPosition = ShoulderPosition.D :
	set(x): shoulders = x; if body_node: body_node.frame = ShoulderPosition.get(x)

enum HeadTilt { L, C, R }
@export var tilt : HeadTilt = HeadTilt.C :
	set(x):
		tilt = x
		if head_node == null: return
		match x:
			HeadTilt.L: head_node.rotation = deg_to_rad(-1)
			HeadTilt.C: head_node.rotation =  0
			HeadTilt.R: head_node.rotation = deg_to_rad(+1)

enum HeadPosition { U, D, L, R, C }
@export var head : HeadPosition = HeadPosition.C :
	set(x):
		head = x
		if head_node == null: return
		match x:
			HeadPosition.U: head_node.position = Vector2.UP    * 2
			HeadPosition.D: head_node.position = Vector2.DOWN  * 2
			HeadPosition.L: head_node.position = Vector2.LEFT  * 2
			HeadPosition.R: head_node.position = Vector2.RIGHT * 2
			_: head_node.position = Vector2.ZERO
