class_name DirectionalAreaDamage extends Area2D

@export var damage: float = 1

func do_damage():
	var bodies = get_overlapping_bodies()
	for i in bodies:
		if i is Wall:
			i.hit(self)
