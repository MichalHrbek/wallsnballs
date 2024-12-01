extends Control

@onready var level = %Level
@onready var _game_area = %GameArea
@export var level_res: LevelRes

const block_scene = preload("res://scenes/ui/editor_wall_block.tscn")
var pos_to_index = {}
var index_to_pos = {}
var shift: int = 0
var selected: Vector2i = Vector2i(0,0)
var selected_index: int = -1

@onready var _orientaion_select: OptionButton = %OrientationSelect
@onready var _type_select: OptionButton = %TypeSelect
@onready var _health: SpinBox = %Health
@onready var _selector: ColorRect = %Selector

func _move(delta: int):
	shift += delta
	level.position.y += delta*Wall.SIZE
	_selector.position.y += delta*Wall.SIZE

func _on_block_event(event: InputEvent, x:int, y: int):
	if event is InputEventMouseButton:
		if event.pressed: return
		if event.button_index != MOUSE_BUTTON_LEFT: return
		#release_focus()
		selected = Vector2i(x,y-shift)
		_update_selection()

func _update_selection():
	_selector.position = Vector2(selected.x*Wall.SIZE,(selected.y+shift)*Wall.SIZE)
	if pos_to_index.has(selected):
		selected_index = pos_to_index[selected]
		var wall: WallRes = level.walls[selected_index].to_res()
		_orientaion_select.disabled = false
		_orientaion_select.select(wall.orientation)
		_type_select.disabled = false
		_type_select.select(wall.type)
		_health.editable = true
		_health.value = wall.health
	else:
		selected_index = -1
		_orientaion_select.disabled = true
		_type_select.disabled = true
		_health.editable = false

func _ready():
	if !level_res:
		level_res = LevelRes.new()
	for y in Level.GAME_HEIGHT+1:
		for x in Level.GAME_WIDTH:
			var b: Control = block_scene.instantiate()
			b.gui_input.connect(_on_block_event.bind(y).bind(x))
			_game_area.add_child(b)
	if level_res:
		for y in level_res.height:
			for x in level_res.width:
				_add_wall(x,y,level_res.walls[x+y*level_res.width])

func _add_wall(x,y,res:WallRes) -> int:
	var index = level._spawn_wall(x,-y-1,res)
	if index != -1:
		pos_to_index[Vector2i(x,y)] = index
		index_to_pos[index] = Vector2i(x,y)
	return index

func _on_name_text_submitted(new_text):
	level_res.name = new_text


func _on_save_pressed():
	pass # TODO: Implement


func _on_add_pressed():
	if selected_index == -1:
		_add_wall(selected.x, selected.y, WallRes.new())
		_update_selection()

func _on_remove_pressed():
	if selected_index != -1:
		level.walls[selected_index].destroy()
		index_to_pos.erase(selected_index)
		pos_to_index.erase(selected)
		selected_index = -1
		_update_selection()


func _on_orientation_select_item_selected(index):
	if selected_index != -1:
		level.walls[selected_index].orientation = index


func _on_type_select_item_selected(index):
	if selected_index != -1:
		var res = level.walls[selected_index].to_res()
		level.walls[selected_index].destroy()
		res.type = index
		selected_index = _add_wall(index_to_pos[selected_index].x, index_to_pos[selected_index].y, res)

func _on_health_value_changed(value):
	if selected_index != -1:
		level.walls[selected_index].health = value