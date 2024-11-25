@tool

extends Node2D

var _initial_size: Vector2
@export var _game_area: Control

func _ready():
	_initial_size = get_viewport_rect().size
	_game_area.item_rect_changed.connect(_on_item_rect_changed)
	get_viewport().size_changed.connect(_on_size_changed)

func _on_size_changed():
	global_position.x = (get_viewport_rect().size.x-_initial_size.x)/2

func _on_item_rect_changed():
	global_position.y = _game_area.global_position.y
