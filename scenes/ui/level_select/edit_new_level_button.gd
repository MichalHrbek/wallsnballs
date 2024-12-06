extends Button

const _level_scene = preload("res://scenes/game/level_editor.tscn")

func _on_pressed():
	GlobalUiState.selected_level = LevelRes.new()
	get_tree().change_scene_to_packed(_level_scene)
