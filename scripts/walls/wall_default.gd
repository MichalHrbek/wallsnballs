class_name WallDefault extends Wall

@onready var label: Label = $Label

func hit(_source) -> bool:
	health -= 1
	_update_health()
	if health <= 0:
		destroy()
	if health >= 0:
		return true
	return false

func round_end():
	pass

func _update_health():
	label.text = str(health)

func _ready():
	_update_health()
