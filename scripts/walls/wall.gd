class_name Wall extends StaticBody2D

signal destroyed

@export var health: int
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
