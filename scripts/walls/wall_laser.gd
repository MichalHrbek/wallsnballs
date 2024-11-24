class_name WallLaser extends Wall

var _got_hit = false

func hit(source) -> bool:
	if source is Ball:
		_got_hit = true
		#LASERRR
	return false

func round_end():
	if _got_hit:
		destroy()
