extends Node

func try_again():
	get_tree().reload_current_scene()

func leave():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
