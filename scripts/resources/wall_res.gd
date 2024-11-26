class_name WallRes extends Resource

enum WallType {NORMAL=0,SLANTED=1,BOMB=2,LASER=3,PLUS_ONE=4}
enum WallOrientation {NONE=0,LEFT=1,TOP_LEFT=2,TOP=3,TOP_RIGHT=4,RIGHT=5,BOTTOM_RIGHT=6,BOTTOM=7,BOTTOM_LEFT=8,LEFT_RIGHT=9,TOP_BOTTOM=10,FOUR_WAY=11}

@export var health: int = 0
@export var type: WallType = WallType.NORMAL
@export var orientation: WallOrientation = WallOrientation.NONE
