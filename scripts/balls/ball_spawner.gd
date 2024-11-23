class_name BallSpawner extends Node2D

var ball_scene = preload("res://scenes/balls/ball.tscn")
@onready var timer = $Timer
@export var balls: int = 1
var _started_shooting: bool = false
var _direction: Vector2

func _process(_delta):
	if _started_shooting and timer.is_stopped() and balls > 0:
		balls -= 1
		var ball: Ball = ball_scene.instantiate()
		ball.direction = _direction
		add_child(ball)
		timer.start()

func _input(event):
	if not _started_shooting:
		if event is InputEventMouseButton:
			if (event.button_index == MOUSE_BUTTON_LEFT and not event.pressed):
				_direction = (event.global_position - global_position).normalized()
				_started_shooting = true
