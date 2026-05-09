extends Control
class_name MultiplayerCursorNavigator

@export var buttons: Array[Button]
@export var player_cursor: Array[TextureRect]
@export var combat_manager: CombatManager

var player_index : Array[int] = [0,0];
var player_action : Array[Character.ACTION_TYPE] = [Character.ACTION_TYPE.NONE, Character.ACTION_TYPE.NONE];

const MAX_CURSOR_ROWS = 2
const MAX_CURSOR_COLS = 3
const CURSOR_SPACING = 40
const CURSOR_BASE_OFFSET = -20

func _ready():
	for i in range(player_index.size()):
		update_cursor_position(i)
	combat_manager.end_of_turn.connect(hide_all_player_navigation)
	

func trigger_player_navigation(player: int, action: Character.ACTION_TYPE) -> void:
	if(!self.is_visible()):
		self.show()

	player_cursor[player].show()
	player_action[player] = action
	update_cursor_position(player)
	pass

func hide_player_navigation(player: int) -> void:
	update_cursor_position(player)
	player_cursor[player].hide()
	player_index[player] = 0

	var allPlayersDone = true
	for i in range(player_index.size()):
		if player_index[i] != -1:
			allPlayersDone = false
			break

	if allPlayersDone:
		self.hide()

func hide_all_player_navigation() -> void:
	for i in range(player_index.size()):
		hide_player_navigation(i)

func _unhandled_input(event):
	for i in range(player_index.size()):
		if event.is_action_pressed("p%d_down" % (i + 1)):
			var row = player_index[i] / MAX_CURSOR_COLS
			var col = player_index[i] % MAX_CURSOR_COLS
			row = (row + 1) % MAX_CURSOR_ROWS
			player_index[i] = min(row * MAX_CURSOR_COLS + col, buttons.size() - 1)
			update_cursor_position(i)

		if event.is_action_pressed("p%d_up" % (i + 1)):
			var row = player_index[i] / MAX_CURSOR_COLS
			var col = player_index[i] % MAX_CURSOR_COLS
			row = (row - 1 + MAX_CURSOR_ROWS) % MAX_CURSOR_ROWS
			player_index[i] = min(row * MAX_CURSOR_COLS + col, buttons.size() - 1)
			update_cursor_position(i)

		if event.is_action_pressed("p%d_left" % (i + 1)):
			var row = player_index[i] / MAX_CURSOR_COLS
			var col = player_index[i] % MAX_CURSOR_COLS
			col = (col - 1 + MAX_CURSOR_COLS) % MAX_CURSOR_COLS
			player_index[i] = min(row * MAX_CURSOR_COLS + col, buttons.size() - 1)
			update_cursor_position(i)

		if event.is_action_pressed("p%d_right" % (i + 1)):
			var row = player_index[i] / MAX_CURSOR_COLS
			var col = player_index[i] % MAX_CURSOR_COLS
			col = (col + 1) % MAX_CURSOR_COLS
			player_index[i] = min(row * MAX_CURSOR_COLS + col, buttons.size() - 1)
			update_cursor_position(i)

		if event.is_action_pressed("p%d_accept" % (i + 1)):
			if player_action[i] != Character.ACTION_TYPE.NONE:
				var enemyIndex = player_index[i]
				on_player_accept(i, enemyIndex)

func update_cursor_position(player):
	var num_players = player_index.size()
	var center_offset = (num_players - 1) / 2.0
	var offset_x = CURSOR_BASE_OFFSET + CURSOR_SPACING * (player - center_offset)
	player_cursor[player].global_position = buttons[player_index[player]].global_position + Vector2(offset_x, 0)


func on_player_accept(player: int, enemyIndex: int) -> void:
	print("Player %d selected button %d" % [player + 1, enemyIndex])
	combat_manager.process_player_action(player, enemyIndex, player_action[player])
	hide_player_navigation(player)
	player_action[player] = Character.ACTION_TYPE.NONE
