extends Control
class_name MultiplayerCursorNavigator

@export var enemy_anchor: Array[Button]
@export var player_cursor: Array[TextureRect]
@export var combat_manager: CombatManager

# var player_action : Array[Character.ACTION_TYPE] = [Character.ACTION_TYPE.NONE];

@export var enemies_number = 4
@export var anchor_grid_start: Vector2 = Vector2(600.0, 300.0)
@export var anchor_grid_end: Vector2 = Vector2(1000.0, 400.0)

var current_cursor_rows = 2
var current_cursor_cols = 3

var player_index : Array[int] = [0];
var player_action: Array[String]= [""]

const CURSOR_SPACING = 40
const CURSOR_BASE_OFFSET = -20

func _ready():
	## Set enemies positions anchor on start
	var enemies_positions = calculate_enemies_position()
	place_enemies_anchor(enemies_positions)

	for i in range(player_index.size()):
		update_cursor_position(i)
# 	combat_manager.end_of_turn.connect(hide_all_player_navigation)
	

func trigger_player_navigation(player: int, action_key: String) -> void:
	if(!self.is_visible()):
		self.show()

	player_cursor[player].show()
	player_action[player] = action_key
	update_cursor_position(player)

func hide_player_navigation(player: int) -> void:
	update_cursor_position(player)
	player_cursor[player].hide()
	player_index[player] = 0
	player_action[player] = ""

	var all_players_done = true
	for i in range(player_index.size()):
		if player_index[i] != -1:
			all_players_done = false
			break

	if all_players_done:
		self.hide()

func hide_all_player_navigation() -> void:
	for i in range(player_index.size()):
		hide_player_navigation(i)

func _unhandled_input(event):
	for i in range(player_index.size()):
		if event.is_action_pressed("P%d_DOWN" % (i + 1)):
			var row = player_index[i] / current_cursor_cols
			var col = player_index[i] % current_cursor_cols
			row = (row + 1) % current_cursor_rows
			player_index[i] = min(row * current_cursor_cols + col, enemy_anchor.size() - 1)
			update_cursor_position(i)

		if event.is_action_pressed("P%d_UP" % (i + 1)):
			var row = player_index[i] / current_cursor_cols
			var col = player_index[i] % current_cursor_cols
			row = (row - 1 + current_cursor_rows) % current_cursor_rows
			player_index[i] = min(row * current_cursor_cols + col, enemy_anchor.size() - 1)
			update_cursor_position(i)

		if event.is_action_pressed("P%d_LEFT" % (i + 1)):
			var row = player_index[i] / current_cursor_cols
			var col = player_index[i] % current_cursor_cols
			col = (col - 1 + current_cursor_cols) % current_cursor_cols
			player_index[i] = min(row * current_cursor_cols + col, enemy_anchor.size() - 1)
			update_cursor_position(i)

		if event.is_action_pressed("P%d_RIGHT" % (i + 1)):
			var row = player_index[i] / current_cursor_cols
			var col = player_index[i] % current_cursor_cols
			col = (col + 1) % current_cursor_cols
			player_index[i] = min(row * current_cursor_cols + col, enemy_anchor.size() - 1)
			update_cursor_position(i)

		if event.is_action_pressed("P%d_ACCEPT" % (i + 1)):
			var enemy_index = player_index[i]
			on_player_accept(i, enemy_index)

func update_cursor_position(player):
	var num_players = player_index.size()
	var center_offset = (num_players - 1) / 2.0
	var offset_x = CURSOR_BASE_OFFSET + CURSOR_SPACING * (player - center_offset)
	player_cursor[player].global_position = enemy_anchor[player_index[player]].global_position + Vector2(offset_x, 0)

func place_enemies_anchor(anchors: Array[Vector2])-> void:
	for i in anchors.size():
		enemy_anchor[i].position = anchors[i]

func calculate_enemies_position() -> Array[Vector2]:
	var cols: int
	var rows: int
	match enemies_number:
		1:
			cols = 1
			rows = 1
		2:
			cols = 2
			rows = 1
		3:
			cols = 3
			rows = 1
		4:
			cols = 2
			rows = 2
		_:
			cols = 3
			rows = 2

	current_cursor_cols = cols
	current_cursor_rows = rows

	var x_spacing := (anchor_grid_end.x - anchor_grid_start.x) / (cols - 1) if cols > 1 else 0.0
	var y_spacing := (anchor_grid_end.y - anchor_grid_start.y) / (rows - 1) if rows > 1 else 0.0
	var x_origin := anchor_grid_start.x if cols > 1 else (anchor_grid_start.x + anchor_grid_end.x) * 0.5
	var y_origin := anchor_grid_start.y if rows > 1 else (anchor_grid_start.y + anchor_grid_end.y) * 0.5

	var positions: Array[Vector2] = []
	for i in range(enemies_number):
		var col: int = i % cols
		var row: int = floori(float(i) / float(cols))
		var new_position = Vector2(x_origin + col * x_spacing - row * 100.0, y_origin + row * y_spacing)
		positions.append(new_position)
		print(new_position)

	return positions

func on_player_accept(player: int, enemy: int) -> void:
	combat_manager.process_player_action(
		player,
		enemy,
		CombatManager.TargetType.ENEMY,
		player_action[player]
	) 
	# combat_manager.process_player_action(player, target_index, target_type)
	hide_player_navigation(player)
# 	player_action[player] = Character.ACTION_TYPE.NONE
