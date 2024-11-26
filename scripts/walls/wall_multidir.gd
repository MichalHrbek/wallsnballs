class_name WallMultiDirectional extends Wall

@export var directional: PackedScene
var _directionals: Array[Node2D] = []

func _on_orientation_set():
	for i in _directionals:
		i.queue_free()
	_directionals = []
	for i in WallRes.ORIENTATION_TO_RAD[orientation]:
		var node: Node2D = directional.instantiate()
		node.rotate(i)
		add_child(node)
		_directionals.append(node)
