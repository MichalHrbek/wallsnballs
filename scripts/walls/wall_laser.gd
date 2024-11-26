@tool

class_name WallLaser extends WallMultiDirectional

var _got_hit = false

func hit(source) -> bool:
	if source is Ball:
		_got_hit = true
		#LASERRR
	return false

func on_round_over():
	if _got_hit:
		destroy()
