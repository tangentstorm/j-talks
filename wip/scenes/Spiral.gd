extends Path3D

@onready var swivel = $"../SwivelCam"
@onready var camera = $"../SwivelCam/Camera3D"
@onready var label = $"../Label"
@onready var ig:ImmediateMesh = ImmediateMesh.new()

func _ready():
	var c:Curve3D = curve
	c.clear_points()
	for i in range(-100,100,1):
		var t:float = i/10.0
		c.add_point(Vector3(cos(t),sin(t), t))
	c.bake_interval = 0.0001
	self.curve = c
	
	
	var m = StandardMaterial3D.new()
	m.flags_use_point_size = true
	m.flags_unshaded = true # flat color
	m.params_point_size = 5
	m.vertex_color_use_as_albedo = true
	m.albedo_color = Color.WHITE
	ig.set_material_override(m)
	get_tree().root.call_deferred('add_child', ig)


var toggle : bool
func _input(e):
	if e is InputEventKey and e.pressed:
		toggle = not toggle
		if toggle:
			camera.projection = Camera3D.PROJECTION_ORTHOGONAL
			label.text = "Orthographic"
			camera.environment.background_color = Color.TEAL
		else:
			camera.projection = Camera3D.PROJECTION_PERSPECTIVE
			label.text = "Perspective"
			camera.environment.background_color = Color.STEEL_BLUE
			


# https://godotengine.org/qa/62948/how-is-the-path3d-visualized-in-the-editor
func _process(_dt):
	swivel.rotation.y += PI/128
	camera.look_at(self.position, Vector3.UP)

	ig.clear()
	ig.begin(Mesh.PRIMITIVE_LINE_STRIP)
	
	for i in range(0,curve.get_point_count()):
		ig.add_vertex(curve.get_point_position(i))
	ig.end()

