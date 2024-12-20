extends Button

signal invalid_data

func import_from_clipboard():
	# TODO: Let user input into a textbox
	var lvl = LevelRes.import_share(DisplayServer.clipboard_get())
	print(lvl)
	if lvl:
		GlobalUiState.selected_level = lvl
		get_tree().change_scene_to_file("res://scenes/game/level_editor.tscn")
	else:
		invalid_data.emit()
