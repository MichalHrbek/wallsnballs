extends Wall

signal sent_back(ball: Ball)

func hit(source) -> bool:
	if source is Ball:
		sent_back.emit(source)
		source.destroy()
	return true
