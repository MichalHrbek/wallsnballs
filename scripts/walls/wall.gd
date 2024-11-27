class_name Wall extends PhysicsBody2D

signal destroyed

const SIZE: float = 72

@export var health: int
@export var orientation: WallRes.WallOrientation = WallRes.WallOrientation.NONE:
	set(value):
		orientation = value
		_on_orientation_set()
var level: Level

func hit(_source) -> bool:
	if health:
		return true
	return false

func on_round_over():
	pass

func destroy():
	destroyed.emit()
	queue_free()

func _on_orientation_set():
	pass
