extends Control

@export var levels: Array[LevelRes] = []

@onready var _item_list: ItemList = %ItemList

const _level_scene = preload("res://scenes/game_static.tscn")

func _ready():
	for i in levels:
		_item_list.add_item(i.name)

func _on_item_list_item_selected(index):
	GlobalUiState.selected_level = levels[index]
	get_tree().change_scene_to_packed(_level_scene)
