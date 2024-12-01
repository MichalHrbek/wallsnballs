class_name WallPlusOne extends Wall

var _got_hit = false

func hit(source) -> bool:
	if not _got_hit:
		if source is Ball and source.sender is BallSpawner:
			_got_hit = true
			source.sender.add_ball()
			destroy()
	return false

func to_res() -> WallRes:
	return WallRes.new(health,WallRes.WallType.PLUS_ONE,orientation)
