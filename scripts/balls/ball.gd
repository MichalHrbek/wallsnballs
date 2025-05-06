class_name Ball extends RigidBody2D

@export var speed: float = 1000
@export var sender: BallSpawner
@export_flags_2d_physics var mask: int = 0b101
@export var direction = Vector2(0,0)
# For animating balls returning to their origin
@export var return_duration: float = 0.3
var _destroyed = false
var ff_ratio: float = 1.0 # Fast forward speedup

func move_along(delta: float):
	position += speed*direction*delta

func _ready():
	apply_central_impulse(direction*speed)

func destroy():
	if not _destroyed:
		_destroyed = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", sender.start_ball.position, return_duration)
		tween.tween_callback(queue_free)


func _on_body_entered(body):
	if body is Wall:
		body.hit(self)
