class_name WallRes extends Resource

enum WallType {NORMAL=0,SLANTED=1,BOMB=2,LASER=3,PLUS_ONE=4}
enum WallOrientation {NONE=0,LEFT=1,TOP_LEFT=2,TOP=3,TOP_RIGHT=4,RIGHT=5,BOTTOM_RIGHT=6,BOTTOM=7,BOTTOM_LEFT=8,LEFT_RIGHT=9,TOP_BOTTOM=10,FOUR_WAY=11}
# Starting from the left going clockwise
const ORIENTATION_TO_RAD = {
	WallOrientation.NONE: [],
	WallOrientation.LEFT: [0],
	WallOrientation.TOP_LEFT: [1*PI/4],
	WallOrientation.TOP: [2*PI/4],
	WallOrientation.TOP_RIGHT: [3*PI/4],
	WallOrientation.RIGHT: [4*PI/4],
	WallOrientation.BOTTOM_RIGHT: [5*PI/4],
	WallOrientation.BOTTOM: [6*PI/4],
	WallOrientation.BOTTOM_LEFT: [7*PI/4],
	WallOrientation.LEFT_RIGHT: [0,PI],
	WallOrientation.TOP_BOTTOM: [PI/2,3*PI/2],
	WallOrientation.FOUR_WAY: [0,PI/2,PI,3*PI/2],
}

@export var health: int = 0
@export var type: WallType = WallType.NORMAL
@export var orientation: WallOrientation = WallOrientation.NONE
