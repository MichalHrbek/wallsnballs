@tool

extends WallDefault

@onready var collider = $CollisionPolygon2D
@onready var sprite = $Polygon2D

func _on_orientation_set():
	_update_rotation()

func _update_rotation():
	if !collider or !sprite or !label:
			return
	var rotation = 0.0
	if orientation == WallRes.WallOrientation.TOP_RIGHT:
		rotation = PI/2
		label.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_LEFT, Control.PRESET_MODE_KEEP_SIZE)
	elif orientation == WallRes.WallOrientation.BOTTOM_RIGHT:
		rotation = PI
		label.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT, Control.PRESET_MODE_KEEP_SIZE)
	elif orientation == WallRes.WallOrientation.BOTTOM_LEFT:
		rotation = -PI/2
		label.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT, Control.PRESET_MODE_KEEP_SIZE)
	else:
		label.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_RIGHT, Control.PRESET_MODE_KEEP_SIZE)
	collider.rotation = rotation
	sprite.rotation = rotation

func _ready():
	_update_rotation()
	_update_health()
