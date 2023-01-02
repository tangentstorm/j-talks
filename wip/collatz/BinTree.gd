tool extends Control

export var depth : int = 6
export var radius : int = 8
export var gap : Vector2 = Vector2(10, 10)

func _draw():
	var oy = 50
	var diam = 2*radius	
	var maxlen = 1<<(depth-1)
	# max width is number of nodes on last layer + given gaps in between
	var max_w = maxlen * (diam+gap.x) - gap.x
	
	for d in range(depth):
		#var row_w = max_w - ((depth-1)-d)*(gap.x+diam) # 
		var rowlen = 1<<d
		var gap_w = ((depth-1)-d)*(gap.x+diam)
		var row_w = rowlen * (diam+gap_w)
		var nw = diam + gap_w
		var nh = diam + gap.y
		
		var ox = (rect_size.x - row_w)/2
		for i in range(rowlen):
			var x = ox + nw * i
			var y = oy + nh * d
			draw_circle(Vector2(x, y), radius, Color.white)
		
