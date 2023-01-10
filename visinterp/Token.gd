@tool extends ColorRect
const JTYPE = preload("res://visinterp/JTYPE.gd").JTYPE

@export (String) var text = ""  : set = set_text
@export (JTYPE) var type = JTYPE.edge : set = set_type

func set_text(t):
	text = t
	if not is_inside_tree(): return # TODO: clean this up!
	if $text != null:
		$text.size.x = 0   # reset to 0 width
		$text.text = t          # this changes the size, too
		var font: Font = $text.get("custom_fonts/font")
		self.size.x = font.get_string_size(t).x + 10

func _ready():
	set("text", text)
	set("type", type)


func set_type(t):
	type = t
	var panel : Color
	var fg : Color = Color("#ffffff")
	match type:
		JTYPE.edge: panel = Color.BLACK
		JTYPE.noun: panel = Color("#16773c")
		JTYPE.verb: panel = Color("#6b2020")
		JTYPE.conj: panel = Color("#b05e22")
		JTYPE.adv:  panel = Color("#b09322")
		JTYPE.lpar:
			panel = Color("#b8a1c5")
			fg = Color("#000000")
		JTYPE.rpar:
			panel = Color("#d549b9")
			fg = Color("#000000")
		JTYPE.cop:
			panel = Color("#acc1c7")
			fg = Color("#000000")
		JTYPE.nb: panel = Color("#666666")
		JTYPE.iden: panel = Color("#6688e3")
		JTYPE.any, _:
			panel = Color("#445c74")
			fg = Color.BLACK

	self.color = panel
	if $text != null:
		$text.set("custom_colors/font_color", fg)
