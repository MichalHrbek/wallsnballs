class_name WallDefault extends Wall

@onready var _label: Label = $Label
@onready var _anim: AnimationPlayer = $AnimationPlayer
@onready var _polygon: Polygon2D = $Polygon2D

func _on_health_depleted():
	destroy()

func hit(_source) -> bool:
	health -= 1
	_update_health()
	if health <= 0:
		_on_health_depleted()
	if health >= 0:
		_anim.play("walls/hit_effect")
		return true
	return false

func on_round_over():
	_polygon.color = level.color_scheme.get_color(self)

func _update_health():
	_label.text = str(health)
	if health == 0:
		_label.visible = false
	else:
		_label.visible = true

func _ready():
	_update_health()
