class_name WallRes extends Resource

enum WallProp {BRICK=0,BOMB=1,LASER=2}

@export var health: int = 0
@export var type: WallProp = WallProp.BRICK
