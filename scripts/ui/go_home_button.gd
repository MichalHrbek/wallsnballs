extends Button

@export var confirm: bool = false
@onready var _dialog: ConfirmationDialog = %ConfirmationDialog

func _on_pressed():
	if confirm:
		_dialog.visible = true
	else:
		go_home()

func go_home():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
