extends Wall

signal reflected(ball: Ball)

func hit(source) -> bool:
	reflected.emit(source)
	return true
