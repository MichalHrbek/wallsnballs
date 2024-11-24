class_name WallDefault extends Wall

@onready var _label: Label = $Label
@onready var _anim: AnimationPlayer = $AnimationPlayer

func hit(_source) -> bool:
	health -= 1
	_update_health()
	if health <= 0:
		destroy()
	if health >= 0:
		_anim.play("walls/hit_effect")
		return true
	return false

func round_end():
	pass

func _update_health():
	_label.text = str(health)

func _ready():
	_update_health()
