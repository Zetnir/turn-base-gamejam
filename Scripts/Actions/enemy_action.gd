extends Action
class_name EnemyAction

var enemy: Enemy

@export var enemy_action_map: Dictionary[String, Variant] = {
	"basic_attack": { "damage": 10, "weight": 40, "action_type":ActionType.ATTACK, "anim":"basicAttack"},
	"guard": { "block": 10, "weight": 30,"action_type":ActionType.PROTECTION, "anim":"guard"},
	"debuff_attack": { "percentReduc": 30, "weight": 15,"action_type":ActionType.DEBUFF, "anim":"debuff"},
	"debuff_defense": { "percentReduc": 30, "weight": 15,"action_type":ActionType.DEBUFF, "anim":"debuff"},
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy = get_parent()
	print(enemy.name)

func apply_action(action_key: String, target: Character)->void:
	var action = enemy_action_map.get(action_key)
	enemy.play_action_anim(action.anim)
	await enemy.get_tree().create_timer(.5).timeout
	match action.action_type:
		ActionType.ATTACK:
			target.on_hit(action.damage)
		ActionType.DEBUFF:
			handle_debuff_action(action, action_key, target)
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

func handle_debuff_action(action: Variant, action_key:String, target: Character)->void:
	match action_key:
		"debuff_attack":
			target.on_debuff_attack(action.percentReduc)
		"debuff_defense":
			target.on_debuff_defense(action.percentReduc)
