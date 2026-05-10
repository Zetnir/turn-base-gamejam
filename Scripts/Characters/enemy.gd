extends Character
class_name Enemy

@export var enemy_action: EnemyAction

var percent_attack = 40
var percent_block = 30
var percent_debuff_attack = 15
var percent_debuff_defense = 15

var next_action_key = ""
var next_target: Character

func _ready() -> void:
	if animated_sprite:
		idle_anim()

# #-------------------------------------------------------------------------------------
# ## Enemy Actions and AI

func process_action(players: Array[Player])-> void:
	enemy_action.apply_action(next_action_key, next_target)
	ui_manager.hide_action_prediction()
	
## Choose Action
## TODO : Choose ActionType based 
func choose_action()->void:
	var total = 0
	var actions = enemy_action.enemy_action_map
	for key in actions:
		total += actions.get(key).weight
	
	var roll = randf_range(0.0,1.0) * total

	var cumulative = 0.0
	var choosen_key = ""
	for key in actions:
		cumulative += actions.get(key).weight
		if roll <= cumulative:
			choosen_key = key
			break

	# var enemy_action = enemy_action.
	print("choose action", choosen_key)
	next_action_key = choosen_key
	display_preview_action_icon(next_action_key)

func display_preview_action_icon(action_key:String)->void:
	var enemy_ui_manager = ui_manager as EnemyUiManager
	var action_type = enemy_action.enemy_action_map.get(action_key).action_type
	enemy_ui_manager.show_action_type_prediction(action_type)

## Return the damage dealt to the target if the enemy is doing damage to this target
func damage_done_to_target(target: Character)->float:
	if target == next_target:
		var enemy_action = enemy_action.enemy_action_map.get(next_action_key)
		if enemy_action.action_type == Action.ActionType.ATTACK:
			return enemy_action.damage * (1 - target.defense_percent / 100)

	return 0.0



## TODO Do the scoring for AI Attack choose
# func score_attack()->float:
# 	var  score = 0.0

# 	if(health / max_health <= 0.4):
# 		score += 35.0
# 	return score

# func score_defense(players: Array[Player])->float:
# 	var score = 0.0

# 	var strongest_power = 0.0
# 	for player in players:
# 		if player.power_percent > strongest_power:
# 			strongest_power = player.power_percent
# 	if strongest_power >= 120.0:
# 		score += 15.0

# 	if(health / max_health <= 0.4):
# 		score += 35.0
# 	return score

# func score_debuff_attack()->float:
# 	return 0.0

# func score_debuff_defense()->float:
# 	return 0.0

## Choose Target
func choose_target(players: Array[Player])->void:
	var target: Player
	var roll_index = randi_range(0,players.size() - 1)
	target = players[roll_index]
	next_target = target

# #-------------------------------------------------------------------------------------
# ## Enemy Animations
