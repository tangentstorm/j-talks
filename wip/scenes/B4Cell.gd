tool class_name B4Cell extends Node2D

enum B4CellType { ANY, HEX, OPCODE, CHAR, VAR, REF }

export(B4CellType) var type = B4CellType.ANY setget set_type
export(int) var value = 0 setget set_value
export(B4vm.B4Op) var op = B4vm.B4Op.NONE setget set_op
export(Color) var bg = Color(0x222222FF) setget set_bg
export(Color) var fg = Color(0xCCCCCCFF) setget set_fg

func set_fg(c): $Label.add_color_override("font_color", c)
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
			self.fg = Color.dimgray
			if value==0: text = '..'
		B4CellType.HEX: self.fg = Color.aliceblue
		B4CellType.OPCODE:
			self.fg = Color.cyan
			if self.value >= B4vm.MIN_OP and self.value <= B4vm.MAX_OP:
				text = B4vm.B4Op.keys()[self.value-B4vm.MIN_OP].to_lower()
		B4CellType.CHAR: self.fg = Color.forestgreen
		B4CellType.VAR: self.fg = Color.goldenrod
		B4CellType.REF: self.fg = Color.ghostwhite
	$Label.text = text
