extends Button

func _on_pressed():
	GlobalUiState.selected_level = LevelRes.new()
	get_tree().change_scene_to_file("res://scenes/game/level_editor.tscn")
