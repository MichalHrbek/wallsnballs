extends CanvasItem

@export var show_on_release = false
@export var show_on_debug = false
@export var hide_on_release = false
@export var hide_on_debug = false
@export var destroy_on_release = false
@export var destroy_on_debug = false

func _ready():
	if OS.is_debug_build():
		if show_on_debug:
			visible = true
		if hide_on_debug:
			visible = false
			process_mode = PROCESS_MODE_DISABLED
		if destroy_on_debug:
			queue_free()
	else:
		if show_on_release:
			visible = true
		if hide_on_release:
			visible = false
			process_mode = PROCESS_MODE_DISABLED
		if destroy_on_release:
			queue_free()
