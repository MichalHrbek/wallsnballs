class_name WallBomb extends WallDefault

@onready var _blast_area: Area2D = $BlastArea
@onready var _explosion = preload("res://scenes/effects/explosion.tscn")

func _on_health_depleted():
	for i in _blast_area.get_overlapping_bodies():
		if i is Wall and i != self:
			i.destroy()
	var e: GPUParticles2D = _explosion.instantiate()
	e.finished.connect(e.queue_free)
	level.effects_node.add_child(e)
	e.global_position = global_position
	var m: ParticleProcessMaterial = e.process_material
	m.color = _polygon.color
	e.restart()
	super()
