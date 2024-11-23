extends Wall

signal sent_back

func hit(_source) -> bool:
	sent_back.emit()
	_source.destroy()
	return true
