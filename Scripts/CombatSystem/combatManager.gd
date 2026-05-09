extends Node
class_name CombatManager

@export var enemies: Array[Enemy]
@export var players: Array[Player]

enum TargetType {
    PLAYER, ENEMY
}
# @export var selectionPanel: EnemySelectionPanel

# var turnIndex = 0
# var isPlayersTurn = false
# var isProcessingTurn = false
# var timeElapsed = 0.0

# signal end_of_turn()

func process_player_action(
    player_index: int,
    target_index: int,
    target_type:TargetType,
    action_index: int
) -> void:
    var player = players[player_index]
    var target: Character
    if target_type == TargetType.ENEMY:
        target = enemies[target_index]
    ## TODO : Enable player targeting in navigator
    if target_type == TargetType.PLAYER:
        target = players[target_index]

    player.process_action(action_index, target)


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
