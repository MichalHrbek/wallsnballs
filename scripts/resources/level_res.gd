class_name LevelRes extends Resource

@export var name: String
@export var width: int = 10
@export var height: int
@export var start: int = 0 # How many rows will be visible when the game starts
@export var balls: int = 25
@export var walls: Array[WallRes]
# 12 13 14 15 16 17
#  6  7  8  9 10 11
#  0  1  2  3  4  5
# -- -- -- -- -- -- * start

# The game area is sized 10x12 walls (A wall in the 13th row means losing)
const GAME_HEIGHT = 12
const GAME_WIDTH = 10
