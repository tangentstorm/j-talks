# function plot node. plot an arbitrary gdscript expression
# over a given range. extends AntiAliasedLine2d so you can
# control line width, etc
@tool
class_name FnPlot
extends AntialiasedLine2D

@export var expr : String = "0" : set = _set_expr

# canvas size (in unscaled pixels)
@export var canvas_size : Vector2 = Vector2(640, 480) : set = _set_canvas_size
@export var steps : int = 64 : set = _set_steps
@export var stops : Vector2 = Vector2(-1,-1) : set = _set_stops

# domain and codomain of the function
@export var x_range : Vector2 = Vector2(-1, 1) : set = _set_x_range
@export var y_range : Vector2 = Vector2(0, 10) : set = _set_y_range

func _set_expr(x):
	expr = x; _rebuild()

func _set_steps(x):
	steps = x; _rebuild()

func _set_stops(x):
	stops = x; _rebuild()

func _set_x_range(x):
	if x.y < x.x:
		var t = x.x; x.x = x.y; x.y = t
		printerr("to plot from right to left, scale by (-1, 1)")
	x_range = x; _rebuild()

func _set_y_range(x):
	if x.y < x.x:
		var t = x.x; x.x = x.y; x.y = t
		printerr("to plot upside down, scale by (1, -1)")
	y_range = x; _rebuild()

func _set_canvas_size(new_size):
	if new_size.x != canvas_size.x:
		points.resize(int(new_size.x))
		points.fill(Vector2.ZERO)
	canvas_size = new_size; _rebuild()

func _rebuild():
	# recalculate the points
	# 'steps' is the number of segments
	# so 'steps + 1' gives the number of distinct points
	var s = steps + 1
	var res = PackedVector2Array()
	var x_dist = x_range.y - x_range.x
	var x_step = x_dist/s
	var x_scale = canvas_size.x / steps
	
	var y_dist = y_range.y - y_range.x  # pixel height
	var y_scale = canvas_size.y / y_dist	
	var y_base = canvas_size.y/2 if (y_range.x<0) else canvas_size.y 
	var e = Expression.new(); e.parse(expr, ['x'])
	var start = 0 if stops.x < 0 else int(stops.x) 
	var stop  = s if stops.y < 0 else int(stops.y)
	var x = x_range.x + start * x_step
	for i in range(start, stop):
		var y0 = e.execute([x])
		if e.has_execute_failed():
			printerr(e.get_error_text())
			break
		var y = y_base - y_scale * y0
		res.append(Vector2(i * x_scale, y))
		x += x_step
	points = res

func _ready():
	_rebuild()
