extends Character
class_name Player

@export var multiplayer_cursor_navigator: MultiplayerCursorNavigator
@export var player_action: PlayerAction

@export var player_index: int = 0

var action_points: int = 0
var can_play: bool = false

var player_ui_manager: PlayerUiManager

# var basic_action = ACTION_TYPE.SWORD
# var strong_action = ACTION_TYPE.ARROW
# var defense_action = ACTION_TYPE.SHIELDx

# var canPlay = false


func _ready():
	super._ready()

	if animated_sprite && !animated_sprite.is_playing():
		animated_sprite.play("idle")

	player_ui_manager = ui_manager as PlayerUiManager
	action_points = stats.max_action_points
	player_ui_manager.update_max_ap(stats.max_action_points)
	player_ui_manager.update_current_ap(action_points)


func _input(event):
	if can_play:
		if event.is_action_pressed("P%d_ACTION_1" % (player_index + 1)):
			multiplayer_cursor_navigator.trigger_player_navigation(player_index, "basic_attack")
		if event.is_action_pressed("P%d_ACTION_2" % (player_index + 1)):
			multiplayer_cursor_navigator.trigger_player_navigation(player_index, "heavy_attack")
		if event.is_action_pressed("P%d_ACTION_3" % (player_index + 1)):
			multiplayer_cursor_navigator.trigger_player_navigation(player_index, "guard", true)
		if event.is_action_pressed("P%d_ACTION_4" % (player_index + 1)):
			multiplayer_cursor_navigator.trigger_player_navigation(player_index, "provocation", true)

# #-------------------------------------------------------------------------------------
# ## Player Actions 

func process_action(action_key: String, target: Character) ->void:
	player_action.apply_action(action_key, target)

func consume_action_points(value: int)->void:
	action_points -= value
	player_ui_manager.update_current_ap(action_points)

func reset_action_points()->void:
	action_points = stats.max_action_points
	player_ui_manager.update_current_ap(stats.max_action_points)

func on_hit(damage: int)->void:
	await super.on_hit(damage)
	var player_ui_manager = (ui_manager as PlayerUiManager)
	player_ui_manager.hide_damage_prediction()

# #-------------------------------------------------------------------------------------
# ## Player UI

func preview_damage_received(damage: float)->void:
	var player_ui_manager = (ui_manager as PlayerUiManager)

	if damage == 0:
		return

	var light = stats.light_damage_threshold
	var medium = stats.medium_damage_threshold
	var high = stats.high_damage_threshold

	if damage < health * light:
		player_ui_manager.show_dmg_prediction(PlayerUiManager.DamageLevel.LIGHT)
	if damage >= health * light && damage < health * medium:
		player_ui_manager.show_dmg_prediction(PlayerUiManager.DamageLevel.MEDIUM)
	if damage >= health * medium && damage < health * high:
		player_ui_manager.show_dmg_prediction(PlayerUiManager.DamageLevel.HIGH)
	if damage >= health * high:
		player_ui_manager.show_dmg_prediction(PlayerUiManager.DamageLevel.VERY_HIGH)
