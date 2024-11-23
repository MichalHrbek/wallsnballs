class_name Ball extends StaticBody2D

@export var speed: float = 5000
@export_flags_2d_physics var mask: int = 1
@export var direction = Vector2(0,0)

func _physics_process(delta):
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
