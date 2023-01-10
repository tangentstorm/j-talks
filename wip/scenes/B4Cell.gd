@tool class_name B4Cell extends Node2D

enum B4CellType { ANY, HEX, OPCODE, CHAR, VAR, REF }

@export var type: B4CellType = B4CellType.ANY : set = set_type
@export var value: int = 0 : set = set_value
@export var op = B4vm.B4Op.NONE setget set_op # (B4vm.B4Op)
@export var panel: Color = Color(0x222222FF) : set = set_bg
@export var fg: Color = Color(0xCCCCCCFF) : set = set_fg

func set_fg(c): $Label.add_theme_color_override("font_color", c)
func set_bg(c): $ColorRect.color = c

func set_type(x):
	type = x; _update()

func set_value(x):
	value = x; _update()
	
func set_op(x):
	op = x; self.value = op

func _ready(): _update()
func _update():
	if not is_inside_tree(): return
	var text : String = "%02X" % (self.value & 0xff)
	match type:
		B4CellType.ANY:
			self.fg = Color.DIM_GRAY
			if value==0: text = '..'
		B4CellType.HEX: self.fg = Color.ALICE_BLUE
		B4CellType.OPCODE:
			self.fg = Color.CYAN
			if self.value >= B4vm.MIN_OP and self.value <= B4vm.MAX_OP:
				text = B4vm.B4Op.keys()[self.value-B4vm.MIN_OP].to_lower()
		B4CellType.CHAR: self.fg = Color.FOREST_GREEN
		B4CellType.VAR: self.fg = Color.GOLDENROD
		B4CellType.REF: self.fg = Color.GHOST_WHITE
	$Label.text = text
