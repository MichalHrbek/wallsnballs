class_name Ball extends CharacterBody2D

@export var speed: float = 1000
@export var sender: BallSpawner
@export_flags_2d_physics var mask: int = 0b101
@export var direction = Vector2(0,0)
# For animating balls returning to their origin
@export var return_duration: float = 0.3
var _destroyed = false
var _rem: float = 0 # The distance the ball needs to catch up in the next tick after hitting a wall

func _physics_process(delta):
	if not _destroyed:
		var goal = to_global(direction*((speed*delta/scale.x)+_rem))
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, goal, mask)
		var result = space_state.intersect_ray(query)
		if result and result.collider is Wall and result.collider.hit(self):
			global_position = lerp(global_position, result.position, 0.99) # :( Close enough
			direction = direction.bounce(result.normal)
			_rem = (goal-result.position).length()
		else:
			_rem = 0
			global_position = goal

func destroy():
	if not _destroyed:
		_destroyed = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", sender.start_ball.position, return_duration)
		tween.tween_callback(queue_free)
