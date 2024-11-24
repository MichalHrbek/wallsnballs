class_name WallPlusOne extends Wall

var _got_hit = false

func hit(source) -> bool:
	if not _got_hit:
		_got_hit = true
		if source is Ball and source.sender is BallSpawner:
			source.sender.add_ball()
			destroy()
	return false
