extends ItemList

@export_enum(Level.CLASSIC_LEVELS_DIR, Level.CUSTOM_LEVELS_DIR)
var level_dir: String = Level.CLASSIC_LEVELS_DIR

@export var level_scene = preload("res://scenes/game/game_static.tscn")

var _levels: Array[LevelRes] = []

func _ready():
	GlobalUiState.selected_level = null
	item_clicked.connect(_on_item_list_item_clicked)
	for i in DirAccess.get_files_at(level_dir):
		_levels.append(load(level_dir+i))
		var label = _levels[-1].name
		if OS.is_debug_build():
			label += " | " + i
		add_item(label)

func _on_item_list_item_clicked(index, _at_position, _mouse_button_index):
	GlobalUiState.selected_level = _levels[index]
	get_tree().change_scene_to_packed(level_scene)
