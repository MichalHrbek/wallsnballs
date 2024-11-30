class_name LevelEndless extends Level

@export var level_res: LevelRes

func _ready():
	width = level_res.width
	_row = level_res.start
	super()

func _spawn_row(row_index:int):
	var y = -row_index-1
	if row_index >= level_res.height or row_index < 0:
		return
	for x in level_res.width:
		var index = row_index*level_res.width+x
		var wall_res = level_res.walls[index]
		walls.append(null)
		_spawn_wall(x,row_index,level_res.walls[index])
