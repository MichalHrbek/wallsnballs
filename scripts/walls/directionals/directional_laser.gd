extends DirectionalAreaDamage

var _tween : Tween
@onready var _line = %Line2D
const _pulse_duration: float = 0.2

func do_damage():
	super()
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(_line, "self_modulate", Color.WHITE, _pulse_duration/2)
	_tween.tween_property(_line, "self_modulate", Color.TRANSPARENT, _pulse_duration/2)
