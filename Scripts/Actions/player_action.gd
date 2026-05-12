extends Action
class_name PlayerAction

var player: Player
@export var audio_manager: Node
@export var abilities: Array[AbilityData] = []

func _ready() -> void:
	player = get_parent()
	if abilities.is_empty():
		_init_default_abilities()

func _init_default_abilities() -> void:
	var basic_atk := AbilityData.new()
	basic_atk.ability_name = "basic_attack"
	basic_atk.damage = 10
	basic_atk.action_type = Action.ActionType.ATTACK
	basic_atk.action_point = 2
	basic_atk.anim = "basicAttack"
	basic_atk.description = "Honestly you can do better..."
	abilities.append(basic_atk)

	var heavy_atk := AbilityData.new()
	heavy_atk.ability_name = "heavy_attack"
	heavy_atk.damage = 30
	heavy_atk.action_type = Action.ActionType.ATTACK
	heavy_atk.action_point = 5
	heavy_atk.anim = "heavyAttack"
	heavy_atk.description = "Damn bro, you're not kidding"
	abilities.append(heavy_atk)

	var guard := AbilityData.new()
	guard.ability_name = "guard"
	guard.block = 10
	guard.action_type = Action.ActionType.PROTECTION
	guard.action_point = 3
	guard.anim = "guard"
	guard.description = "Ok ok you're a big guy, i get it"
	abilities.append(guard)

	var provocation := AbilityData.new()
	provocation.ability_name = "provocation"
	provocation.percent_reduc = 30
	provocation.action_type = Action.ActionType.PROVOCATION
	provocation.action_point = 4
	provocation.anim = "provocation"
	provocation.description = "You're so annoying, If i could i would hit you too"
	abilities.append(provocation)

func find_ability(ability_name: String) -> AbilityData:
	for ability in abilities:
		if ability.ability_name == ability_name:
			return ability
	return null

func apply_action(action_key: String, target: Character) -> void:
	var ability = find_ability(action_key)
	if not ability:
		return
	if player.action_points >= ability.action_point:
		match ability.action_type:
			Action.ActionType.ATTACK:
				player.consume_action_points(ability.action_point)
				player.play_action_anim(ability.anim)
				player.audio_manager.process_action_sound(action_key, player.position)

				player.can_play = false
				await player.get_tree().create_timer(.5).timeout
				player.can_play = true

				target.on_hit(ability.damage)
			Action.ActionType.ATK_DEBUFF:
				pass
			Action.ActionType.DEF_DEBUFF:
				pass
			Action.ActionType.BUFF:
				pass
			Action.ActionType.PROTECTION:
				player.consume_action_points(ability.action_point)
				player.play_action_anim(ability.anim)

				player.can_play = false
				await player.get_tree().create_timer(.5).timeout
				player.can_play = true

				player.on_protection(ability.block)
			Action.ActionType.PROVOCATION:
				pass
	else:
		print("player %d don't have enough mana for action" % [player.player_index])
