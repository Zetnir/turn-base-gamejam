extends Node
class_name CombatManager

@export var cursor_navigator: MultiplayerCursorNavigator
@export var game_status_manager: GameStatusManager

@export var enemies: Array[Enemy]
@export var players: Array[Player]

enum TargetType {
	PLAYER, ENEMY
}

var is_processing_turn = false
var is_players_turn = false
var is_enemies_turn = false
var is_combat_won = false
var is_combat_lost = false

var turn_index = 0

@export var turn_time_window = 10
@export var enemy_turn_window = 0.5
@export var test_label: Label


# var turnIndex = 0
# var isPlayersTurn = false
# var isProcessingTurn = false
# var timeElapsed = 0.0

# signal end_of_turn()

func _ready() -> void:
	is_players_turn = true

func _process(_delta):
	if is_players_turn && !is_processing_turn:
		handle_players_turn()
	elif is_enemies_turn && !is_processing_turn:
		handle_enemies_turn()

	if !is_combat_won && !is_combat_lost:
		check_enemy_death()
		check_player_death()
		check_combat_status()

# #-------------------------------------------------------------------------------------
# # Helpers


# #-------------------------------------------------------------------------------------
# ## Enemies

func handle_enemies_turn()->void:
	is_processing_turn = true
	turn_index +=1

	print("process enemy turn")

	for enemy in enemies:
		if enemy:
			enemy.process_action(players)
			if is_combat_lost:
				pass
			await get_tree().create_timer(enemy_turn_window).timeout

	await get_tree().create_timer(2).timeout
	is_enemies_turn = false
	is_players_turn = true
	is_processing_turn = false

func enemies_preview_action()->void:
	for enemy in enemies:
		if enemy :
			enemy.choose_action()
			enemy.choose_target(players)
	await get_tree().create_timer(enemy_turn_window).timeout

func check_enemy_death()->void:
	for enemy_index in enemies.size():
		var enemy = enemies.get(enemy_index)
		if enemy && enemy.health <= 0:
			cursor_navigator.deactivate_selection_at(enemy_index)
			await get_tree().create_timer(.7).timeout
			if enemy && !enemy.is_dead:
				enemy.is_dead = true
				enemy.death_anim()
				enemy.queue_free()
			break

# #-------------------------------------------------------------------------------------
# ## Players 

func handle_players_turn()->void:
	is_processing_turn = true

	enemies_preview_action()
	preview_damage_received()

	for player in players:
		if player :
			player.can_play = true
			player.reset_action_points()

	## TODO : Remove after tests
	test_label.text = "Players turn"

	print("handle player turn")
	await get_tree().create_timer(turn_time_window).timeout

	is_enemies_turn = true
	is_players_turn = false
	is_processing_turn = false
	for player in players:
		player.can_play = false

	cursor_navigator.hide_all_player_navigation()

	## TODO : Remove after tests
	test_label.text = "Enemies turn"

func preview_damage_received()->void:
	for player in players:
		if player : 
			var total_damage = 0
			for enemy in enemies:
				if enemy:
					total_damage += enemy.damage_done_to_target(player)
			player.preview_damage_received(total_damage)
		
func check_player_death()->void:
	for player_index in players.size():
		var player = players.get(player_index)
		if player && player.health <= 0:
			await get_tree().create_timer(1.5).timeout
			if player && !player.is_dead:
				player.is_dead = true
				player.death_anim()
				player.queue_free()
			break

func check_combat_status()->void:
	print(enemies.size())
	if  enemies.filter(func(x): return x != null).size() <= 0:
		print("all enemies dead")
		is_combat_won = true
		game_status_manager.toggle_victory_screen()
		for player in players:
			player.can_play = false

	if  players.filter(func(x): return x != null).size() <= 0:
		is_combat_lost = true
		game_status_manager.toggle_death_screen()


func process_player_action(
	player_index: int,
	target_index: int,
	target_type:TargetType,
	action_key: String
) -> void:
	var player = players[player_index]
	var target: Character
	if target_type == TargetType.ENEMY:
		target = enemies[target_index]
	## TODO : Enable player targeting in navigator
	if target_type == TargetType.PLAYER:
		target = players[target_index]

	player.process_action(action_key, target)

# func _process(_delta: float) -> void:
# 	if !isPlayersTurn:
# 		# Process enemy turns
# 		if !isProcessingTurn:
# 			print("test")
# 			isProcessingTurn = true
# 			enemies_turn()
# 	else :
# 		if !isProcessingTurn:
# 			players_turn()


# func enemies_turn() -> void:
# 	print("Enemy's turn!")

# 	## Check for dead enemies and remove them from the list
# 	for enemy in enemies:
# 		if enemy.health <= 0:
# 			enemies.remove_at(enemies.find(enemy))
# 			continue

# 	## Process enemy actions
# 	for enemy in enemies:
# 		if players[0].health > 0:
# 			enemy.attack(players[0])
# 			await sleep(0.6)
# 		else:
# 			break

# 	isPlayersTurn = !isPlayersTurn
# 	for player in players:
# 		player.canPlay = isPlayersTurn
# 	isProcessingTurn = false

# func players_turn() -> void:
# 	isProcessingTurn = true
# 	print("Player's turn!")
# 	await sleep(10.0)

# 	isPlayersTurn = !isPlayersTurn
# 	for player in players:
# 		player.canPlay = isPlayersTurn
# 	isProcessingTurn = false
# 	end_of_turn.emit()

# func sleep(seconds: float) -> void:
# 	await get_tree().create_timer(seconds).timeout

# # func _ready() -> void:
# # 	selectionPanel.enemy_selected.connect(hitEnemy)
# # 	pass
	
# # func _process(delta: float) -> void:
# # 	pass

# # func handle_enemies_turn() ->void:
# # 	pass
	
# # func handle_players_turn() ->void:
# # 	pass

# # func hitEnemy(index: int, damage: int) -> void:
# # 	if index >= 0 && index < enemies.size():
# # 		var enemy = enemies[index]
# # 		if enemy.has_method("onHit"):
# # 			enemy.onHit(damage)
