class_name LevelEndless extends Level

@export var difficulty: Curve

func _ready():
	width = 10
	_row = 2
	super()

func _spawn_row(row_index:int):
	for x in width:
		var wall_res = null
		if randf() < 0.3 + (0.5*difficulty.sample(min(1.0,_row/100.0))):
			wall_res = WallRes.new()
			wall_res.health = randi_range(1, 99)
			if randf() < 0.1:
				wall_res.type = WallRes.WallType.BOMB
				
		elif randf() < 0.1:
			wall_res = WallRes.new()
			wall_res.type = WallRes.WallType.LASER
			wall_res.orientation = [WallRes.WallOrientation.LEFT_RIGHT,WallRes.WallOrientation.TOP_BOTTOM,WallRes.WallOrientation.FOUR_WAY].pick_random()
		elif randf() < 0.05:
			wall_res = WallRes.new()
			wall_res.type = WallRes.WallType.PLUS_ONE
		
		walls.append(null)
		_spawn_wall(x,row_index,wall_res)

func _check_win():
	pass
