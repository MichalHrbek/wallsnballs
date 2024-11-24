class_name BallSpawner extends Node2D

@export var wait_time: float = 0.02
@onready var timer: float = 0
@onready var line = $Line2D
@onready var start_ball = $StartBall
@export var level: Level
@export var n_balls: int = 1
var balls_shot: int = 0
var balls_returned: int = 0
var _started_shooting: bool = false
var _direction: Vector2
var _deployed: Array[Ball] = []

func _ray(origin: Vector2, dir: Vector2, exclude: Array[RID]=[]) -> Dictionary:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(origin, to_global(dir*99999), 0b100, exclude)
	var result = space_state.intersect_ray(query)
	return result

func _process(delta):
	timer += delta
	if _started_shooting and timer>=wait_time and balls_shot < n_balls:
		# Firing the balls
		line.visible = false
		balls_shot += 1
		var ball: Ball = start_ball.duplicate()
		ball.direction = _direction
		_deployed.append(ball)
		add_child(ball)
		timer -= wait_time
		
	if not _started_shooting:
		# Aim hint drawing
		line.visible = true
		var dir = (get_global_mouse_position() - start_ball.global_position).normalized()
		var r1 = _ray(start_ball.global_position, dir)
		var r2 = _ray(r1.position, dir.bounce(r1.normal), [r1.collider.get_rid()])
		line.points[0] = to_local(start_ball.global_position)
		line.points[1] = to_local(r1.position)
		line.points[2] = to_local(r2.position)
	

func _input(event):
	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_RIGHT and not event.pressed):
			recall()
		if not _started_shooting:
			if (event.button_index == MOUSE_BUTTON_LEFT and not event.pressed):
				_direction = (event.global_position - start_ball.global_position).normalized()
				_started_shooting = true

func on_return_ball(ball: Ball):
	if balls_returned == 0:
		start_ball.global_position.x = ball.global_position.x
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
	balls_shot = 0
	balls_returned = 0
	_started_shooting = false
	if level:
		level.next_round()

func _ready():
	start_ball.global_position = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y-10)

func add_temp_ball(ball: Ball):
	_deployed.append(ball)
