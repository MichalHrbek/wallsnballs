class_name Ball extends StaticBody2D

@export var speed: float = 5000
@export var sender: BallSpawner
@export_flags_2d_physics var mask: int = 1
@export var direction = Vector2(0,0)
# For animating balls returning to their origin
@export var return_duration: float = 0.3
var _destroyed = false

func _physics_process(delta):
	if not _destroyed:
		var goal = to_global(direction*speed*delta)
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, goal, mask)
		var result = space_state.intersect_ray(query)
		if result and result.collider is Wall and result.collider.hit(self):
			direction = direction.bounce(result.normal)
			#print(result)
		else:
			global_position = goal

var end_pos: Vector2
func destroy():
	if not _destroyed:
		end_pos = position
		_destroyed = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", sender.start_ball.position, return_duration)
		tween.tween_callback(queue_free)
