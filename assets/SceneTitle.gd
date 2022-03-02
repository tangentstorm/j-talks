tool extends Node2D
# Animated Scene Title

signal animation_finished

export (String) var text setget set_text
export (int) var text_len setget set_text_len
export var stripe_x = 0 setget set_stripe_x
export var stripe_y = 0 setget set_stripe_y
export var stripe_w = 0 setget set_stripe_w
export var stripe_h = 0 setget set_stripe_h
export (Color) var stripe_color = Color.silver setget set_stripe_color

onready var anim = $"animation"
onready var stripe = $stripe
onready var label = $label

func _ready():
	anim.play('init')
	yield(anim, "animation_finished")

func reveal(new_text):
	# does title animation and then emits 'animation_finished'
	text = new_text
	text_len = 0
	anim.play("reveal"); yield(anim, "animation_finished")
	anim.play('init'); yield(anim, "animation_finished")
	emit_signal('animation_finished')

func set_stripe_y(y):
	stripe_y = y
	if stripe: stripe.rect_position.y = y
	
func set_stripe_x(x):
	stripe_x = x
	if stripe: stripe.rect_position.x = x

func set_stripe_w(w):
	stripe_w = w
	if stripe: stripe.rect_size.x = w
	
func set_stripe_h(h):
	stripe_h = h
	if stripe: stripe.rect_size.y = h

func set_stripe_color(c):
	stripe_color = c
	if stripe: stripe.color = c

func set_text(t):
	text = t
	set("text_len", len(t))
		
func set_text_len(n):
	text_len = int(n)
	if not text or not label: return
	if n > 0: $label.text = text.substr(0,n)
	else: $label.text = ""
