extends Action
class_name EnemyAction

var enemy: Enemy
@export var audio_manager: Node
@export var enemy_action_map: Dictionary[String, Variant] = {
	"basic_attack": { "damage": 10, "weight": 40, "action_type":ActionType.ATTACK, "anim":"basicAttack"},
	"guard": { "block": 10, "weight": 30,"action_type":ActionType.PROTECTION, "anim":"guard"},
	"debuff_attack": { "percentReduc": 20, "weight": 15,"action_type":ActionType.ATK_DEBUFF, "anim":"debuff"},
	"debuff_defense": { "percentReduc": 20, "weight": 15,"action_type":ActionType.DEF_DEBUFF, "anim":"debuff"},
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy = get_parent()
	print(enemy.name)

func apply_action(action_key: String, target: Character)->void:
	var action = enemy_action_map.get(action_key)
	print(action)
	print(enemy)
	enemy.play_action_anim(action.anim)
	enemy.audio_manager.process_action_sound(action_key,enemy.position)

	await enemy.get_tree().create_timer(.5).timeout
	match action.action_type:
		ActionType.ATTACK:
			target.on_hit(action.damage)
		ActionType.ATK_DEBUFF:
			target.on_debuff_attack(action.percentReduc)
		ActionType.DEF_DEBUFF:
			target.on_debuff_defense(action.percentReduc)
		ActionType.BUFF:
			pass
		ActionType.PROTECTION:
			enemy.on_protection(action.block)
			# player.consume_action_points(action.action_point)
			# player.play_action_anim(action.anim)
			# await player.get_tree().create_timer(.5).timeout
			# target.on_hit(action.block)
		ActionType.PROVOCATION:
			pass
			# player.consume_action_points(action.action_point)
			# player.play_action_anim(action.anim)
			# await player.get_tree().create_timer(.5).timeout
			# target.on_hit(action.percentAggro)
