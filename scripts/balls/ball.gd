class_name Ball extends StaticBody2D

@export var speed: float = 5000
@export var sender: BallSpawner
@export_flags_2d_physics var mask: int = 1
@export var direction = Vector2(0,0)
# For animating balls returning to their origin
@export var return_progress: float = 0
var _destroyed = false
@onready var _anim: AnimationPlayer = $AnimationPlayer

func _physics_process(delta):
	if not _destroyed:
		var goal = to_global(direction*speed*delta)
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, goal, mask)
		var result = space_state.intersect_ray(query)
		if result:
			if result.collider is Wall:
				if result.collider.hit(self):
					direction = direction.bounce(result.normal)
			#print(result)
		else:
			global_position = goal
	else:
		position = end_pos.lerp(sender.start_ball.position, return_progress)

var end_pos: Vector2
func destroy():
	if not _destroyed:
		end_pos = position
		_destroyed = true
		_anim.play("ball_return")
		_anim.animation_finished.connect(queue_free.unbind(1))
