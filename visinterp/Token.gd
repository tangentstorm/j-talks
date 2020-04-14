tool extends Node2D

enum JTYPE { noun, verb, adv, conj, lpar, rpar, iden, cop, nb, any, none }

export (String) var text = ""  setget set_text
export (JTYPE) var type = JTYPE.none setget set_type

func set_text(t):
	text = t
	if ($text != null):
		$text.rect_size.x = 0   # reset to 0 width
		$text.text = t          # this changes the size, too
		if ($bg != null):
			$bg.rect_size.x = $text.rect_size.x + 20 # resize box, plus margin

func _ready():
	set("text", text)
	set("type", type)


func set_type(t):
	type = t
	var bg : Color
	var fg : Color = Color("#ffffff")
	match type:
		JTYPE.noun: bg = Color("#16773c")
		JTYPE.verb: bg = Color("#6b2020")
		JTYPE.conj: bg = Color("#b05e22")
		JTYPE.adv:  bg = Color("#b09322")
		JTYPE.lpar:
			bg = Color("#b8a1c5")
			fg = Color("#000000")
		JTYPE.rpar:
			bg = Color("#d549b9")
			fg = Color("#000000")
		JTYPE.cop:
			bg = Color("#acc1c7")
			fg = Color("#000000")
		JTYPE.nb: bg = Color("#666666")
		JTYPE.iden: bg = Color("#6688e3")
		JTYPE.any, _:
			 bg = Color.black
	if ($bg != null and $text != null):
		$bg.color = bg
		$text.set("custom_colors/font_color", fg)
