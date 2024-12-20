extends Button

@export var level_editor: LevelEditor

func export_into_clipboard():
	DisplayServer.clipboard_set(level_editor.level_res.export_share())
