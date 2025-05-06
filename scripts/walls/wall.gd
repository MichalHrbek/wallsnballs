class_name Wall extends CollisionObject2D

signal destroyed

const SIZE: float = 72

@export var health: int:
	set(value):
		health = value
		_on_health_set()
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

func _on_health_set():
	pass

func to_res() -> WallRes:
	return WallRes.new(health,WallRes.WallType.NORMAL,orientation)
