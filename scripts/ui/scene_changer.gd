extends Node

@export var scene: PackedScene

func _change_scene():
	get_tree().change_scene_to_packed(scene)
