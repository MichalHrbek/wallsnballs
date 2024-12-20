class_name LevelRes extends Object

var name: String = ""
var width: int = 10
var height: int = 0
var start: int = 0 # How many rows will be visible when the game starts
var balls: int = 25
var walls: Array[WallRes] = []
var file_path: String
# 12 13 14 15 16 17
#  6  7  8  9 10 11
#  0  1  2  3  4  5

const CUSTOM_LEVELS_DIR = "user://levels/"
const EASY_LEVELS_DIR = "res://levels/easy/"
const NORMAL_LEVELS_DIR = "res://levels/normal/"
const HARD_LEVELS_DIR = "res://levels/hard/"

static func parse_format(data: String, path: String = "") -> LevelRes:
	var level = LevelRes.new()
	if path:
		level.file_path = path
	var lines: Array[String] = []
	for i in data.split("\n"):
		if i.begins_with(";"):
			continue
		lines.append(i)
	if len(lines) < 5:
		return null
	var format_version = lines[0]
	level.name = lines[1]
	level.width = int(lines[2].split(" ")[0])
	level.height = int(lines[2].split(" ")[1])
	level.start = int(lines[3])
	level.balls = int(lines[4])
	level.walls.resize(level.width*level.height)
	if len(lines) < 5+level.height:
		return level
	for i in level.height:
		var l = lines[i+5].split("|")
		for j in level.width:
			var index = (level.height-1-i)*level.width+j
			level.walls[index] = WallRes.parse_format(l[j])
	return level

static func load_from_file(path: String) -> LevelRes:
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	return parse_format(content, path)

func export_format() -> String:
	var data = ""
	data = "1\n%s\n%d %d\n%d\n%d\n" % [name,width,height,start,balls]
	for i in height:
		for j in width:
			var index = (height-1-i)*width+j
			if walls[index]:
				data += walls[index].export_format()
			if j != width-1:
				data += "|"
		data += "\n"
	return data

func export_share() -> String:
	var data = export_format()
	data = data.sha1_text() + "\n" + data
	return Marshalls.utf8_to_base64(data)

static func import_share(data: String) -> LevelRes:
	var decoded = Marshalls.base64_to_utf8(data)
	decoded.sha1_text()
	var check = decoded.substr(0,40)
	var level_data = decoded.substr(41)
	print_debug(check, " - ", level_data.sha1_text())
	if check == level_data.sha1_text():
		return parse_format(decoded.substr(41))
	else:
		return null
