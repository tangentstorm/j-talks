tool extends Control

export var b:float = 0.0 setget set_b
export var m:float = 1.0 setget set_m
export var dist:float = 0 setget set_dist
export var nk: Vector2 = Vector2(1, 0) setget set_nk   # when to draw dots (ex: 2 1 = odd)
export var color:Color = Color.cornflower setget set_color

func set_color(c):
	color = c
	update()

func set_b(new_b):
	b = new_b
	update()
	
func set_m(new_m):
	m = new_m
	update()

func set_dist(d):
	dist = d
	update()
	
func set_nk(v):
	nk = v
	update()

func _draw():
	var origin : Vector2 = get_parent().origin()
	var unit = get_parent().unit
	var px = 0; var py = -unit.y*b
	for x in range(50):
		var y = b + m * x
		var gx = unit.x * x
		var gy = -unit.y * y
		if x % int(nk.x) == int(nk.y):
			draw_circle(origin + Vector2(gx, gy), 5, color)
			if (x > 0) and (x < dist):
				draw_line(origin+Vector2(px, py),
						  origin+Vector2(gx, gy), color, 2.5)
			px = gx; py = gy
