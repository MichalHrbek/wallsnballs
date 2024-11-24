class_name Level extends Node2D

@export var lvl: LevelRes
@export var ball_spawner: BallSpawner
var brick_size: float
var brick_scale: float

var wall_scene = preload("res://scenes/walls/wall_default.tscn")
var slanted_scene = preload("res://scenes/walls/wall_slanted.tscn")
var barrier_scene = preload("res://scenes/walls/wall_barrier.tscn")
var destroyer_scene = preload("res://scenes/walls/wall_destroyer.tscn")
var walls: Array[Wall] = []

func _ready():
	# World borders
	var left = barrier_scene.instantiate()
	var right = barrier_scene.instantiate()
	var top = barrier_scene.instantiate()
	var bottom = destroyer_scene.instantiate()
	top.rotation_degrees = -90
	bottom.rotation_degrees = -90
	right.position.x = get_viewport_rect().size.x
	left.scale.y = get_viewport_rect().size.y
	right.scale.y = get_viewport_rect().size.y
	top.scale.y = get_viewport_rect().size.y
	bottom.scale.y = get_viewport_rect().size.y
	bottom.position.y = get_viewport_rect().size.y
	add_child(left)
	add_child(right)
	add_child(top)
	add_child(bottom)
	if ball_spawner:
		bottom.sent_back.connect(ball_spawner.on_return_ball)
	
	# Spawning bricks
	brick_size = get_viewport_rect().size.x / lvl.width
	brick_scale = brick_size / 40
	for i in lvl.height:
		for j in lvl.width:
			var index = i*lvl.width+j
			var wall_res = lvl.walls[index]
			walls.append(null)
			if wall_res:
				var node: Wall
				if wall_res.type == WallRes.WallType.NORMAL:
					node = wall_scene.instantiate()
				elif wall_res.type == WallRes.WallType.SLANTED:
					node = slanted_scene.instantiate()
				if node:
					node.apply_scale(Vector2(brick_scale,brick_scale))
					node.position += Vector2(brick_size*(j+0.5),brick_size*(i+0.5))
					node.health = wall_res.health
					node.level = self
					node.orientation = wall_res.orientation
					add_child(node)
					walls[index] = node
					node.destroyed.connect(_on_wall_destroyed.bind(node,index))

func _on_wall_destroyed(_wall: Wall, index: int):
	walls[index] = null

func next_round():
	pass
