class_name LevelStatic extends Level

@export var level_res: LevelRes

func _ready():
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
		if wall_res:
			var node: Wall = _wall_scenes[wall_res.type].instantiate()
			if node:
				node.health = wall_res.health
				node.level = self
				walls_node.add_child(node)
				node.position += Vector2(Wall.SIZE*(x+0.5),Wall.SIZE*(y+0.5))
				node.orientation = wall_res.orientation
				walls[index] = node
				node.destroyed.connect(_on_wall_destroyed.bind(node,index))