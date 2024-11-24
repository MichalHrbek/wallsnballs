@tool

extends WallDefault

@onready var _collider = $CollisionPolygon2D
@onready var _sprite = $Polygon2D

func _on_orientation_set():
	_update_rotation()

func _update_rotation():
	if !_collider or !_sprite or !_label:
			return
	var rot = 0.0
	if orientation == WallRes.WallOrientation.TOP_RIGHT:
		rot = PI/2
		_label.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_LEFT, Control.PRESET_MODE_KEEP_SIZE)
	elif orientation == WallRes.WallOrientation.BOTTOM_RIGHT:
		rot = PI
		_label.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT, Control.PRESET_MODE_KEEP_SIZE)
	elif orientation == WallRes.WallOrientation.BOTTOM_LEFT:
		rot = -PI/2
		_label.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT, Control.PRESET_MODE_KEEP_SIZE)
	else:
		_label.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_RIGHT, Control.PRESET_MODE_KEEP_SIZE)
	_collider.rotation = rot
	_sprite.rotation = rot

func _ready():
	_update_rotation()
	_update_health()
