tool extends Control

const gw = 30
const gh = 30

export var b = 1 setget set_b
export var m = 3 setget set_m

func set_b(new_b):
	b = new_b
	_draw()
	
func set_m(new_m):
	m = new_m
	_draw()

func _draw():
	var origin : Vector2 = get_parent().origin()
	var px; var py
	for x in range(50):
		var y = b + m * x
		var gx = gw * x
		var gy = -gh * y
		draw_circle(origin + Vector2(gx, gy), 5, Color.cornflower)
		if x > 0:
			draw_line(origin+Vector2(px, py),
					  origin+Vector2(gx, gy), Color.cornflower, 2.5)
		px = gx; py = gy
