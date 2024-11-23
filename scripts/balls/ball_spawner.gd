class_name BallSpawner extends Node2D

var ball_scene = preload("res://scenes/balls/ball.tscn")
@onready var timer = $Timer
@onready var line = $Line2D
@export var level: Level
@export var n_balls: int = 1
@onready var balls_left: int = n_balls
var balls_returned: int = 0
var _started_shooting: bool = false
var _direction: Vector2
var _deployed: Array[Ball] = []

func _ray(origin: Vector2, dir: Vector2, exclude: Array[RID]=[]) -> Dictionary:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(origin, to_global(dir*9999), 0b100, exclude)
	var result = space_state.intersect_ray(query)
	return result

func _process(_delta):
	if _started_shooting and timer.is_stopped() and balls_left > 0:
		# Firing the balls
		line.visible = false
		balls_left -= 1
		var ball: Ball = ball_scene.instantiate()
		ball.direction = _direction
		_deployed.append(ball)
		add_child(ball)
		timer.start()
	if not _started_shooting:
		# Aim hint drawing
		line.visible = true
		var dir = (get_global_mouse_position() - global_position).normalized()
		var r1 = _ray(global_position, dir)
		var r2 = _ray(r1.position, dir.bounce(r1.normal), [r1.collider.get_rid()])		
		line.points[1] = to_local(r1.position)
		line.points[2] = to_local(r2.position)

func _input(event):
	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_RIGHT and not event.pressed):
			recall()
		if not _started_shooting:
			if (event.button_index == MOUSE_BUTTON_LEFT and not event.pressed):
				_direction = (event.global_position - global_position).normalized()
				_started_shooting = true

func return_ball():
	balls_returned += 1
	if balls_returned == n_balls:
		reset()

func recall():
	for i in _deployed:
		if is_instance_valid(i):
			i.destroy()
	reset()

func reset():
	_deployed = []
	balls_left = n_balls
	balls_returned = 0
	_started_shooting = false
	if level:
		level.next_round()
