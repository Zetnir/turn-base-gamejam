extends Character
class_name Player

@export var multiplayer_cursor_navigator: MultiplayerCursorNavigator
@export var player_action: PlayerAction

@export var light_damage_tresh = 0.2
@export var medium_damage_tresh = 0.4
@export var high_damage_tresh = 0.4

@export var player_index: int = 0

@export var max_action_points: int = 6
var action_points:int = max_action_points
var can_play: bool = false

var player_ui_manager: PlayerUiManager

# var basic_action = ACTION_TYPE.SWORD
# var strong_action = ACTION_TYPE.ARROW
# var defense_action = ACTION_TYPE.SHIELDx

# var canPlay = false


func _ready() -> void:
	if animated_sprite && !animated_sprite.is_playing():
		animated_sprite.play("idle")

	player_ui_manager = ui_manager as PlayerUiManager
	player_ui_manager.update_current_ap(action_points)


func _input(event):
	if can_play:
		if event.is_action_pressed("P%d_ACTION_1" % (player_index + 1)):
			multiplayer_cursor_navigator.trigger_player_navigation(player_index, "basic_attack")
		if event.is_action_pressed("P%d_ACTION_2" % (player_index + 1)):
			multiplayer_cursor_navigator.trigger_player_navigation(player_index, "heavy_attack")
		if event.is_action_pressed("P%d_ACTION_3" % (player_index + 1)):
			multiplayer_cursor_navigator.trigger_player_navigation(player_index, "guard")
		if event.is_action_pressed("P%d_ACTION_4" % (player_index + 1)):
			multiplayer_cursor_navigator.trigger_player_navigation(player_index, "provocation")

# #-------------------------------------------------------------------------------------
# ## Player Actions 

func process_action(action_key: String, target: Character) ->void:
	print("target : ", target)
	player_action.apply_action(action_key, target)

func consume_action_points(value: int)->void:
	action_points -= value
	player_ui_manager.update_current_ap(action_points)

func reset_action_points()->void:
	action_points = max_action_points
	player_ui_manager.update_current_ap(max_action_points)

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

	if damage < health * light_damage_tresh:
		player_ui_manager.show_dmg_prediction(PlayerUiManager.DamageLevel.LIGHT)
	if damage >= health * light_damage_tresh && damage < health * medium_damage_tresh:
		player_ui_manager.show_dmg_prediction(PlayerUiManager.DamageLevel.MEDIUM)
	if damage >= health * medium_damage_tresh && damage < health * high_damage_tresh:
		player_ui_manager.show_dmg_prediction(PlayerUiManager.DamageLevel.HIGH)
	if damage >= health * high_damage_tresh:
		player_ui_manager.show_dmg_prediction(PlayerUiManager.DamageLevel.VERY_HIGH)
