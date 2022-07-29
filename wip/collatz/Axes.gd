tool extends Control

export var line_color:Color = Color.cyan setget set_line_color
export var axis_color:Color = Color.blue setget set_axis_color
export var unit: Vector2 = Vector2(30,30) setget set_unit



func set_line_color(c:Color):
	line_color = c
	refresh()

func set_axis_color(c:Color):
	axis_color = c
	refresh()
	
func set_unit(u:Vector2):
	unit = u
	refresh()
	
func refresh():
	update()
	for child in get_children():
		child.update()

var gymax
var gxmax
var ymax
var ymin
var xmin
var xmax

func _ready():
	gymax = floor(rect_size.y / unit.y)
	gxmax = floor(rect_size.x / unit.x)
	ymax = floor(rect_size.y)
	ymin = ymax - (gymax * unit.y)
	xmin = 0
	xmax = gxmax * unit.x

func origin() -> Vector2:
	_ready()
	return Vector2(xmin, ymax)

func _draw():
	_ready()
	for x in range(gxmax+1):
		draw_line(Vector2(xmin+x*unit.x, ymin), Vector2(xmin+x*unit.x, ymax), line_color)
	for y in range(gymax+1):
		draw_line(Vector2(xmin, ymin+y*unit.y), Vector2(xmax, ymin+y*unit.y), line_color)
		
