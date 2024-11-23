extends Wall

signal sent_back(ball: Ball)

func hit(_source) -> bool:
	sent_back.emit(_source)
	_source.destroy()
	return true
