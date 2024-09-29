@tool extends Node2D

@onready var brow_node = $"neck/head/brow"
@onready var mouth_node = $"neck/head/mouth"
@onready var eyes_node = $"neck/head/eyes"
@onready var head_node = $"neck/head"
@onready var body_node = $"body"


enum MouthSprite { A, B, C, D, E, F, G, H, X }
@export var mouth : MouthSprite = MouthSprite.X :
	set(x): mouth = x; mouth_node.frame = int(x)

enum EyeSprite { LEFT, CENTER, RIGHT, CLOSED }
@export var eyes : EyeSprite = EyeSprite.CENTER :
	set(x): eyes = x; eyes_node.frame = int(x)

enum BrowSprite { LEFT, UP, DOWN, NEUTRAL }
@export var brow : BrowSprite = BrowSprite.NEUTRAL :
	set(x): brow = x; brow_node.frame = int(x)

enum HeadTilt { L, C, R }
@export var tilt : HeadTilt = HeadTilt.C :
	set(x):
		tilt = x
		match x:
			HeadTilt.L: head_node.rotation = deg_to_rad(-1)
			HeadTilt.C: head_node.rotation =  0
			HeadTilt.R: head_node.rotation = deg_to_rad(+1)

enum ShoulderPosition { R, U, L, D }
@export var shoulders : ShoulderPosition = ShoulderPosition.D :
	set(x): shoulders = x; body_node.frame = int(x)

enum HeadPosition { U, D, L, R, C }
@export var head : HeadPosition = HeadPosition.C :
	set(x):
		head = x
		match x:
			HeadPosition.U: head_node.position = Vector2.UP    * 2
			HeadPosition.D: head_node.position = Vector2.DOWN  * 2
			HeadPosition.L: head_node.position = Vector2.LEFT  * 2
			HeadPosition.R: head_node.position = Vector2.RIGHT * 2
			_: head_node.position = Vector2.ZERO
