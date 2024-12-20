extends Button

@export var level_editor: LevelEditor

func export_into_clipboard():
	level_editor.write_to_res()
	DisplayServer.clipboard_set(level_editor.level_res.export_share())
