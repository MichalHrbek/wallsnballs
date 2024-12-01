@tool

class_name WallLaser extends WallMultiDirectional

var _got_hit = false

func hit(source) -> bool:
	if source is Ball:
		_got_hit = true
		for i in _directionals:
			i.do_damage()
	return false

func on_round_over():
	if _got_hit:
		destroy()

func to_res() -> WallRes:
	return WallRes.new(health,WallRes.WallType.LASER,orientation)
