class_name ColorSchemeLinear extends ColorScheme

@export var color_max = Color.BLACK
@export var color_zero = Color.WHITE
var _max_health: int = 1

func on_round_over(level: Level):
	var t = 1
	for i in level.walls:
		if i:
			t = max(t, i.health)
	_max_health = t

func get_color(wall: Wall) -> Color:
	var t = float(wall.health) / _max_health
	return color_max * t + color_zero * (1-t)
