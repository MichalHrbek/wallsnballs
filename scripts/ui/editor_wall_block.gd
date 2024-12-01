extends ColorRect

func _on_focus_entered():
	color.a = 0.25


func _on_focus_exited():
	color.a = 0.0
