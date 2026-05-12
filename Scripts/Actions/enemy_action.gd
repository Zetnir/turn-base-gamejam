extends Action
class_name EnemyAction

var enemy: Enemy
@export var audio_manager: Node
@export var abilities: Array[AbilityData] = []

func _ready() -> void:
	enemy = get_parent()
	if abilities.is_empty():
		_init_default_abilities()

func _init_default_abilities() -> void:
	var basic_atk := AbilityData.new()
	basic_atk.ability_name = "basic_attack"
	basic_atk.damage = 10
	basic_atk.weight = 40
	basic_atk.action_type = Action.ActionType.ATTACK
	basic_atk.anim = "basicAttack"
	abilities.append(basic_atk)

	var guard := AbilityData.new()
	guard.ability_name = "guard"
	guard.block = 10
	guard.weight = 30
	guard.action_type = Action.ActionType.PROTECTION
	guard.anim = "guard"
	abilities.append(guard)

	var debuff_atk := AbilityData.new()
	debuff_atk.ability_name = "debuff_attack"
	debuff_atk.percent_reduc = 20
	debuff_atk.weight = 15
	debuff_atk.action_type = Action.ActionType.ATK_DEBUFF
	debuff_atk.anim = "debuff"
	abilities.append(debuff_atk)

	var debuff_def := AbilityData.new()
	debuff_def.ability_name = "debuff_defense"
	debuff_def.percent_reduc = 20
	debuff_def.weight = 15
	debuff_def.action_type = Action.ActionType.DEF_DEBUFF
	debuff_def.anim = "debuff"
	abilities.append(debuff_def)

func apply_action(ability: AbilityData, target: Character) -> void:
	enemy.play_action_anim(ability.anim)
	enemy.audio_manager.process_action_sound(ability.ability_name, enemy.position)

	await enemy.get_tree().create_timer(.5).timeout
	match ability.action_type:
		Action.ActionType.ATTACK:
			target.on_hit(ability.damage)
		Action.ActionType.ATK_DEBUFF:
			target.on_debuff_attack(ability.percent_reduc)
		Action.ActionType.DEF_DEBUFF:
			target.on_debuff_defense(ability.percent_reduc)
		Action.ActionType.BUFF:
			pass
		Action.ActionType.PROTECTION:
			enemy.on_protection(ability.block)
		Action.ActionType.PROVOCATION:
			pass
