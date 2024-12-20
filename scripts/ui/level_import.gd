extends LineEdit

signal invalid_data

func import_from_clipboard():
	import_from_string(DisplayServer.clipboard_get())

func import_from_string(data: String):
	var lvl = LevelRes.import_share(data)
	if lvl:
		GlobalUiState.selected_level = lvl
		get_tree().change_scene_to_file("res://scenes/game/level_editor.tscn")
	else:
		invalid_data.emit()

func import():
	if text:
		import_from_string(text.strip_edges())

# Needed to allow pasting
func _on_focus_entered():
	if OS.has_feature("web"):
		var resp = JavaScriptBridge.eval("window.prompt()")
		if resp:
			text = resp
