class_name WallBomb extends WallDefault

@onready var _blast_area: Area2D = $BlastArea
@onready var _explosion = preload("res://scenes/effects/explosion.tscn")

func _on_health_depleted():
	var bodies = _blast_area.get_overlapping_bodies()
	process_mode = PROCESS_MODE_DISABLED
	
	# Destroying nearby walls
	for i in bodies:
		if i is Wall and i != self:
			if i is WallDefault:
				i._on_health_depleted()
			else:
				i.destroy()
	
	# Spawning the explosion effect
	var e: GPUParticles2D = _explosion.instantiate()
	e.finished.connect(e.queue_free)
	level.effects_node.add_child(e)
	e.global_position = global_position
	var m: ParticleProcessMaterial = e.process_material
	m.color = _polygon.color
	e.restart()
	
	super()

func to_res() -> WallRes:
	return WallRes.new(health,WallRes.WallType.BOMB,orientation)
