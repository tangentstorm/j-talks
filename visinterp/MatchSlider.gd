extends AnimationPlayer

func slide(dx:int, dy:int):
	$Root.position += Vector2(dx,dy)
