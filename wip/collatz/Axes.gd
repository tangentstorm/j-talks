tool extends Control

const gh = 30
const gw = 30

var gymax
var gxmax
var ymax
var ymin
var xmin
var xmax

func _ready():
	gymax = floor(rect_size.y / gh)
	gxmax = floor(rect_size.x / gw)
	ymax = floor(rect_size.y)
	ymin = ymax - (gymax * gh)
	xmin = 0
	xmax = gxmax * gw

func origin() -> Vector2:
	_ready()
	return Vector2(xmin, ymax)

func _draw():
	_ready()
	print("xmin:", xmin, " max: ", xmax, " ymin:", ymin, " max: ", ymax) 
	for x in range(gxmax+1):
		draw_line(Vector2(xmin+x*gw, ymin), Vector2(xmin+x*gw, ymax), Color.blueviolet)
	for y in range(gymax+1):
		draw_line(Vector2(xmin, ymin+y*gh), Vector2(xmax, ymin+y*gh), Color.blueviolet)
		
