class_name LevelStatic extends Level

@export var level_res: LevelRes

func _ready():
	if !level_res:
		level_res = GlobalUiState.selected_level
	ball_spawner.n_balls = level_res.balls
	ball_spawner.reset()
	width = level_res.width
	_row = level_res.start
	super()

func _spawn_row(row_index:int):
	if row_index >= level_res.height or row_index < 0:
		return
	for x in level_res.width:
		var index = row_index*level_res.width+x
		walls.append(null)
		_spawn_wall(x,row_index,level_res.walls[index])
