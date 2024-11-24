class_name Wall extends StaticBody2D

signal destroyed

@export var health: int
@export var orientation: WallRes.WallOrientation = 0:
	set(value):
		orientation = value
		_on_orientation_set()
var level: Level

func hit(_source) -> bool:
	if health:
		return true
	return false

func round_end():
	pass

func destroy():
	destroyed.emit()
	queue_free()

func _on_orientation_set():
	pass
