extends Node2D

@onready var _level = $Level

func _ready():
	_level.game_ended.connect(_on_game_ended)
	_level.round_ended.connect(_on_round_ended)

func _on_game_ended(status: Level.GameStatus):
	#process_mode = PROCESS_MODE_DISABLED
	if status == Level.GameStatus.WON:
		$WinDialog.visible = true
	elif status == Level.GameStatus.LOST:
		$LoseDialog.visible = true

func change_speed(k: float):
	Engine.time_scale *= k

func _on_round_ended():
	Engine.time_scale = 1
