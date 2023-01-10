# Graph of the 3x+1 dynamical system.
extends Control

var data = []
var chart_scale = Vector2(5,-5)
var chart_xy = Vector2(20, 1000)
var count = 512
export var radius = 2
export(Color) var color = Color.white
var paused = false

onready var timer = Timer.new()

func _ready():
	VisualServer.set_default_clear_color(Color.royalblue)
	timer.autostart = 1
	timer.wait_time = 0.08
	timer.paused = true
	timer.connect("timeout", self, "step")
	add_child(timer)
	reset_data()

func reset_data():
	data = []
	for i in count: data.push_back(i)
	update()

func step():
	for i in len(data):
		var x = data[i]
		if x&1: x=(1+3*x)
		data[i] = x >> 1
	update()

func toggle_animation():
	timer.paused = not timer.paused

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(e):
	if e is InputEventKey and e.pressed:
		match e.scancode:
			KEY_SPACE: toggle_animation()
			KEY_ESCAPE: reset_data()
			_: step()

func _draw():
	
	for i in len(data):
		var xy = Vector2(i, data[i]) # log(data[i])
		draw_circle(chart_xy + chart_scale * xy, radius, color)
