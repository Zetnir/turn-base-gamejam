extends Character
class_name Enemy

@export var enemy_action: EnemyAction

var next_action: AbilityData
var next_target: Character

func _ready():
	super._ready()
	if animated_sprite:
		idle_anim()

# #-------------------------------------------------------------------------------------
# ## Enemy Actions and AI

func process_action(_players: Array[Player]) -> void:
	enemy_action.apply_action(next_action, next_target)
	ui_manager.hide_action_prediction()

func choose_action() -> void:
	var total = 0
	for ability in enemy_action.abilities:
		total += ability.weight

	var roll = randf_range(0.0, 1.0) * total

	var chosen: AbilityData = enemy_action.abilities[0]
	var cumulative = 0.0
	for ability in enemy_action.abilities:
		cumulative += ability.weight
		if roll <= cumulative:
			chosen = ability
			break

	next_action = chosen
	display_preview_action_icon(next_action)

func display_preview_action_icon(ability: AbilityData) -> void:
	var enemy_ui_manager = ui_manager as EnemyUiManager
	enemy_ui_manager.show_action_type_prediction(ability.action_type)

func damage_done_to_target(target: Character) -> float:
	if target == next_target:
		if next_action and next_action.action_type == Action.ActionType.ATTACK:
			return next_action.damage * (1 - target.defense_percent / 100)
	return 0.0

func choose_target(players: Array[Player]) -> void:
	var roll_index = randi_range(0, players.size() - 1)
	next_target = players[roll_index]

# #-------------------------------------------------------------------------------------
# ## Enemy Animations
