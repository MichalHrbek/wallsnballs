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
		rot = WallRes.ORIENTATION_TO_RAD[orientation][0]-PI/4
		_label.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_LEFT, Control.PRESET_MODE_KEEP_SIZE)
	elif orientation == WallRes.WallOrientation.BOTTOM_RIGHT:
		rot = WallRes.ORIENTATION_TO_RAD[orientation][0]-PI/4
		_label.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT, Control.PRESET_MODE_KEEP_SIZE)
	elif orientation == WallRes.WallOrientation.BOTTOM_LEFT:
		rot = WallRes.ORIENTATION_TO_RAD[orientation][0]-PI/4
		_label.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT, Control.PRESET_MODE_KEEP_SIZE)
	else:
		_label.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_RIGHT, Control.PRESET_MODE_KEEP_SIZE)
	_collider.rotation = rot
	_sprite.rotation = rot

func _ready():
	_update_rotation()
	super()

func to_res() -> WallRes:
	return WallRes.new(health,WallRes.WallType.SLANTED,orientation)
