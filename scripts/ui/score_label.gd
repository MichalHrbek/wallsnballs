extends Control

@onready var _anim: AnimationPlayer = $AnimationPlayer
@onready var _label: Label = $Label

func set_score(new_score: int):
	_label.text = str(new_score)
	_anim.play("ui/slight_bump")
