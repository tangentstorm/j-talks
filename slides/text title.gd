tool extends Node2D

export (String) var text setget set_text
export (float) var text_len setget set_text_len
export var stripe_x = 0 setget set_stripe_x
export var stripe_y = 0 setget set_stripe_y
export var stripe_w = 0 setget set_stripe_w
export var stripe_h = 0 setget set_stripe_h

func set_stripe_y(y):
	stripe_y = y
	if $stripe != null:
		$stripe.rect_position.y = y
	
func set_stripe_x(x):
	stripe_x = x
	if $stripe != null:
		$stripe.rect_position.x = x

func set_stripe_w(w):
	stripe_w = w
	if $stripe != null:
		$stripe.rect_size.x = w
	
func set_stripe_h(h):
	stripe_h = h
	if $stripe != null:
		$stripe.rect_size.y = h

func set_text(t):
	text = t
	set("text_len", len(t))
		
func set_text_len(n):
	text_len = int(n)
	if text == null or text == '': return
	if $label == null: return
	if n > 0: $label.text = text.substr(0,n)
	else: $label.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
