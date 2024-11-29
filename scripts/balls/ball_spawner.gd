class_name BallSpawner extends Node2D

@export var wait_time: float = 0.02
@onready var timer: float = 0
@onready var line = $Line2D
@onready var start_ball = $StartBall
@onready var label = %Label
@onready var label_anchor = $LabelAnchor
@export var level: Level
@export var n_balls: int = 1
@onready var balls_left: int = n_balls
var balls_returned: int = 0
var balls_fired: int = 0
var _started_shooting: bool = false
var _direction: Vector2
var _deployed: Array[Ball] = []

func _ray(origin: Vector2, dir: Vector2, exclude: Array[RID]=[]) -> Dictionary:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(origin, to_global(dir*999999), 0b100, exclude)
	var result = space_state.intersect_ray(query)
	return result

func _process(delta):
	timer += delta
	if _started_shooting and timer>=wait_time and balls_left > 0:
		# Firing the balls
		balls_left -= 1
		balls_fired += 1
		var ball: Ball = start_ball.duplicate()
		ball.direction = _direction
		_deployed.append(ball)
		add_child(ball)
		timer -= wait_time
		_update_label()
		
	if not _started_shooting:
		#_update_aim_hint()
		pass

func _update_aim_hint():
	var dir = (get_global_mouse_position() - start_ball.global_position).normalized()
	if dir != Vector2.ZERO:
		var r1 = _ray(start_ball.global_position, dir)
		var r2 = _ray(r1.position, dir.bounce(r1.normal), [r1.collider.get_rid()])
		line.points[0] = to_local(start_ball.global_position)
		line.points[1] = to_local(r1.position)
		line.points[2] = to_local(r2.position)
	

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if not _started_shooting:
			_update_aim_hint()
	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_RIGHT and not event.pressed):
			recall()
		if not _started_shooting:
			if (event.button_index == MOUSE_BUTTON_LEFT and not event.pressed):
				_direction = (event.global_position - start_ball.global_position).normalized()
				_started_shooting = true
				line.visible = false

func on_return_ball(ball):
	if ball is Ball:
		if balls_returned == 0:
			start_ball.global_position.x = ball.global_position.x
		ball.destroy()
		balls_returned += 1
		if balls_left == 0 and balls_returned == balls_fired:
			reset()
		_update_label()

func recall():
	for i in _deployed:
		if is_instance_valid(i):
			i.destroy()
	reset()

func reset():
	_deployed = []
	balls_left = n_balls
	balls_returned = 0
	balls_fired = 0
	_started_shooting = false
	_update_aim_hint()
	line.visible = true
	_update_label()
	level.next_round()

func _ready():
	start_ball.position = Vector2(level.screen_size.x/2, level.screen_size.y-10)
	_update_label()

func _update_label():
	label_anchor.position = start_ball.position
	label.text = "%d/%d" % [n_balls-balls_fired+balls_returned, n_balls]

func add_temp_ball(ball: Ball):
	_deployed.append(ball)

func add_ball():
	n_balls += 1
	_update_label()
