class_name Level extends Node2D

signal round_ended
signal game_ended(status: GameStatus)

@export var lvl: LevelRes
@export var ball_spawner: BallSpawner
@export var screen_size: Vector2
@export var color_scheme: ColorScheme
var status: GameStatus = GameStatus.IN_PROGRESS:
	set(value):
		status = value
		if value != GameStatus.IN_PROGRESS:
			game_ended.emit(value)
var walls: Array[Wall] = []

enum GameStatus {IN_PROGRESS = 0, LOST = 1, WON = 2}

const _wall_scenes = {
	WallRes.WallType.NORMAL: preload("res://scenes/walls/wall_default.tscn"),
	WallRes.WallType.SLANTED: preload("res://scenes/walls/wall_slanted.tscn"),
	WallRes.WallType.PLUS_ONE: preload("res://scenes/walls/wall_plus_one.tscn"),
	WallRes.WallType.LASER: preload("res://scenes/walls/wall_laser.tscn"),
}
const _slide_duration: float = 0.3

@onready var _walls_group = $Walls

func _ready():
	$BottomBorder.reflected.connect(ball_spawner.on_return_ball)
	# Spawning bricks
	for i in lvl.height:
		for j in lvl.width:
			var index = i*lvl.width+j
			var wall_res = lvl.walls[index]
			walls.append(null)
			if wall_res:
				var node: Wall = _wall_scenes[wall_res.type].instantiate()
				if node:
					node.health = wall_res.health
					node.level = self
					_walls_group.add_child(node)
					node.position += Vector2(Wall.SIZE*(j+0.5),Wall.SIZE*(i+0.5))
					node.orientation = wall_res.orientation
					walls[index] = node
					node.destroyed.connect(_on_wall_destroyed.bind(node,index))
	color_scheme.on_round_over(self)
	for i in walls:
		if i:
			i.on_round_over()

func _on_wall_destroyed(_wall: Wall, index: int):
	walls[index] = null

func next_round():
	walls.count(null)
	color_scheme.on_round_over(self)
	for i in walls:
		if i:
			i.on_round_over()
	var tween = get_tree().create_tween()
	tween.tween_property(_walls_group, "position", _walls_group.position+Vector2(0,Wall.SIZE), _slide_duration)
	round_ended.emit()
