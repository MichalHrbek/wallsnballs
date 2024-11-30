class_name Level extends Node2D

signal round_ended
signal game_ended(status: GameStatus)

@export var ball_spawner: BallSpawner
@export var screen_size: Vector2 = Vector2(720,936)
@export var color_scheme: ColorScheme = preload("res://assets/color_scheme_default.tres")
var status: GameStatus = GameStatus.IN_PROGRESS:
	set(value):
		status = value
		if value != GameStatus.IN_PROGRESS:
			game_ended.emit(value)
var walls: Array[Wall] = []

var _tween: Tween
var _row = 0
var width: int

@onready var _lose_trigger: Area2D = $LoseTrigger

enum GameStatus {IN_PROGRESS = 0, LOST = 1, WON = 2}

const _wall_scenes = {
	WallRes.WallType.NORMAL: preload("res://scenes/walls/wall_default.tscn"),
	WallRes.WallType.SLANTED: preload("res://scenes/walls/wall_slanted.tscn"),
	WallRes.WallType.PLUS_ONE: preload("res://scenes/walls/wall_plus_one.tscn"),
	WallRes.WallType.LASER: preload("res://scenes/walls/wall_laser.tscn"),
	WallRes.WallType.BOMB: preload("res://scenes/walls/wall_bomb.tscn"),
}
const _slide_duration: float = 0.3

@onready var walls_node = $Walls
@onready var effects_node = $Effects

func _ready():
	$BottomBorder.reflected.connect(ball_spawner.on_return_ball)
	# Spawning bricks
	for i in _row:
		_spawn_row(i)
	walls_node.position.y += Wall.SIZE*_row
	
	color_scheme.on_round_over(self)
	for i in walls:
		if i:
			i.on_round_over()

func _spawn_row(_row_index:int):
	pass

func _spawn_wall(x:int, y:int, wall: WallRes):
	var index = x + y*width
	if wall:
		var node: Wall = _wall_scenes[wall.type].instantiate()
		if node:
			node.health = wall.health
			node.level = self
			walls_node.add_child(node)
			node.position += Vector2(Wall.SIZE*(x+0.5),Wall.SIZE*((-y-1)+0.5))
			node.orientation = wall.orientation
			walls[index] = node
			node.destroyed.connect(_on_wall_destroyed.bind(node,index))

func _check_win():
	if(walls.count(null) == len(walls)):
		print("YOU WON")
		status = GameStatus.WON

func _check_loss():
	for i in _lose_trigger.get_overlapping_bodies():
		if i is Wall:
			print("YOU LOST")
			status = GameStatus.LOST

func _on_wall_destroyed(_wall: Wall, index: int):
	walls[index] = null

func next_round():
	_spawn_row(_row)
	_row += 1
	_check_win()
	color_scheme.on_round_over(self)
	for i in walls:
		if i:
			i.on_round_over()
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(walls_node, "position", Vector2(0,_row*Wall.SIZE), _slide_duration)
	_tween.tween_callback(_check_loss)
	round_ended.emit()
