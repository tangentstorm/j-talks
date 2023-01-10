extends Node2D

signal bit_changed(i)
signal int_changed(value)

func _on_BitModel_changed(bits, as_int):
	$value.text = str(as_int)
	for child in $hbox.get_children():
		child.queue_free()
	for i in range(48, -1, -1):
		var dup = $bit.duplicate()
		dup.visible = true
		dup.connect("pressed",Callable(self,"_on_bit_changed").bind(i))
		if i < len(bits) and bits[i]: dup.button_pressed = true
		$hbox.add_child(dup)

func _on_value_text_entered(new_text):
	var value = int(new_text)
	emit_signal("int_changed", value)

func _on_bit_changed(bit):
	print("bit changed: ", bit)
	emit_signal("bit_changed", bit)
