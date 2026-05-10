extends Action
class_name EnemyAction

var enemy: Enemy

@export var enemy_action_map: Dictionary[String, Variant] = {
	"basic_attack": { "damage": 10, "action_type":ActionType.ATTACK, "anim":"basicAttack"},
	"guard": { "block": 10,"action_type":ActionType.PROTECTION, "anim":"guard"},
	"debuff_attack": { "percentReduc": 30,"action_type":ActionType.DEBUFF, "anim":"debuff"},
	"debuff_defense": { "percentReduc": 30,"action_type":ActionType.DEBUFF, "anim":"debuff"},
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy = get_parent()
	print(enemy.name)

# func apply_action(action_key: String, target: Character)->void:
# 	var action = player_action_map.get(action_key)
# 	if(player.action_points >= action.action_point):
# 		match action.action_type:
# 			ActionType.ATTACK:
# 				print("player:", player.name)
# 				player.consume_action_points(action.action_point)
# 				player.play_action_anim(action.anim)
# 				await player.get_tree().create_timer(.5).timeout
# 				target.on_hit(action.damage)
# 			ActionType.DEBUFF:
# 				pass
# 			ActionType.BUFF:
# 				pass
# 			ActionType.PROTECTION:
# 				pass
# 				# player.consume_action_points(action.action_point)
# 				# player.play_action_anim(action.anim)
# 				# await player.get_tree().create_timer(.5).timeout
# 				# target.on_hit(action.block)
# 			ActionType.PROVOCATION:
# 				pass
# 				# player.consume_action_points(action.action_point)
# 				# player.play_action_anim(action.anim)
# 				# await player.get_tree().create_timer(.5).timeout
# 				# target.on_hit(action.percentAggro)
# 	else:
# 		print("player %d don't have enough mana for action" % [player.player_index])
