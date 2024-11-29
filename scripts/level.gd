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
var _tween: Tween

@onready var _lose_trigger: Area2D = $LoseTrigger
@onready var _row = lvl.start

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
	for i in _row:
		_spawn_row(i)
	_walls_group.position.y += Wall.SIZE*_row
	
	color_scheme.on_round_over(self)
	for i in walls:
		if i:
			i.on_round_over()

func _spawn_row(row_index:int):
	var y = -row_index-1
	if row_index >= lvl.height or row_index < 0:
		return
	for x in lvl.width:
		var index = row_index*lvl.width+x
		var wall_res = lvl.walls[index]
		walls.append(null)
		if wall_res:
			var node: Wall = _wall_scenes[wall_res.type].instantiate()
			if node:
				node.health = wall_res.health
				node.level = self
				_walls_group.add_child(node)
				node.position += Vector2(Wall.SIZE*(x+0.5),Wall.SIZE*(y+0.5))
				node.orientation = wall_res.orientation
				walls[index] = node
				node.destroyed.connect(_on_wall_destroyed.bind(node,index))

func _check_loss():
	for i in _lose_trigger.get_overlapping_bodies():
		if i is Wall:
			print("YOU LOST")
			status = GameStatus.LOST
			return

func _on_wall_destroyed(_wall: Wall, index: int):
	walls[index] = null

func next_round():
	_spawn_row(_row)
	_row += 1
	if(walls.count(null) == len(walls)):
		print("YOU WON")
		status = GameStatus.WON
		return
	color_scheme.on_round_over(self)
	for i in walls:
		if i:
			i.on_round_over()
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(_walls_group, "position", Vector2(0,_row*Wall.SIZE), _slide_duration)
	_tween.tween_callback(_check_loss)
	round_ended.emit()
