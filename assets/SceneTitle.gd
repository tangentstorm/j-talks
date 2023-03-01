@tool extends Node2D
# Animated Scene Title

signal animation_finished

@export var text : String : set = set_text
@export var text_len : int : set = set_text_len
@export var stripe_color : Color = Color.SILVER : set = set_stripe_color

@onready var anim = $"animation"
@onready var stripe = $stripe
@onready var label = $label

func _ready():
	anim.play('init')
	await anim.animation_finished

func reveal(new_text):
	# does title animation and then emits 'animation_finished'
	text = new_text
	text_len = 0
	anim.play("reveal"); await anim.animation_finished
	anim.play('init'); await anim.animation_finished
	emit_signal('animation_finished')

func set_stripe_color(c):
	stripe_color = c
	if stripe: stripe.color = c

func set_text(t):
	text = t
	set("text_len", len(t))
		
func set_text_len(n):
	text_len = int(n)
	if text=="" or label==null: return
	if n > 0: $label.text = text.substr(0,n)
	else: $label.text = ""
