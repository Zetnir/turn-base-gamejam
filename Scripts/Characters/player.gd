class_name Player
extends Character

@export var multiplayer_cursor_navigator: MultiplayerCursorNavigator
@export var player_action: PlayerAction

@export var animated_sprite: AnimatedSprite2D

@export var player_index: int = 0

var max_action_points: int = 6
var action_points:int = max_action_points

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


# #-------------------------------------------------------------------------------------
# ## Player Animations

func idle_anim()->void:
	animated_sprite.play("idle")

func play_action_anim(animation_key: String)->void:
	animated_sprite.play(animation_key)
	animated_sprite.animation_finished.connect(idle_anim, CONNECT_ONE_SHOT)

func hurt_anim()->void:
	animated_sprite.play("hurt")
	animated_sprite.animation_finished.connect(idle_anim, CONNECT_ONE_SHOT)

func death_anim()->void:
	animated_sprite.play("death")

# func process_action(action: Character.ACTION_TYPE, target: Character) -> void:
# 	var playerAction = PlayerAction.new(self)
# 	match action:
# 		Character.ACTION_TYPE.SWORD:
# 			playerAction.SwordAttack(target)
# 			pass
# 		Character.ACTION_TYPE.ARROW:
# 			playerAction.ArrowAttack(target)
# 			pass
# 		Character.ACTION_TYPE.SHIELD:
# 			playerAction.ShieldBlock(target)
# 			pass
# 		Character.ACTION_TYPE.NONE:
# 			pass




# # func handle_player_inputs() -> void:
# # 	pass , 

# 	# if Input.is_action_just_pressed("basic_attack"):
# 	# 	basic_attack()
# 	# if Input.is_action_just_pressed("strong_attack"):
# 	# 	strong_attack()
	
# 	# enemySelectionPanel.enemy_selected.connect(confirm_attack)
# 	# if Input.is_action_just_pressed("confirm") && isSelectingTarget:
# 	# 	confirm_attack()

# 	#-----------------------------------------------------------------------------------

# # func basic_attack() -> void:
# # 	actionType = ACTION_TYPE.BASIC_ATTACK
# # 	if(enemySelectionPanel):
# # 		toggleSelection()
		
# # func strong_attack() -> void:
# # 	actionType = ACTION_TYPE.STRONG_ATTACK
# # 	if(enemySelectionPanel):
# # 		toggleSelection()
	
# # func toggleSelection() -> void:
# # 		enemySelectionPanel.toggle_display_panel()
# # 		isSelectingTarget = !isSelectingTarget

# # func onHit(damage: int) -> void:
# # 	health -= damage
# # 	healthBar.update_health(health)
# # 	print("Player hit! Current health: %d" % health)
	
# # func confirm_attack(index: int) -> void:
# # 	match actionType:
# # 		ACTION_TYPE.BASIC_ATTACK:
# # 			start_basic_attack_anim()
# # 			pass
# # 		ACTION_TYPE.STRONG_ATTACK:
# # 			start_strong_attack_anim()
# # 			pass
# # 		ACTION_TYPE.DEFENSE:
# # 			pass
# # 		ACTION_TYPE.NONE:
# # 			pass
# # 	toggleSelection()
	

# #-----------------------------------------------------------------------------------
# ## Animation Handlers

# func idle() -> void:
# 	animated_sprite.play("Idle")
	
# func handleHurtAnimation() -> void:
# 	animated_sprite.play("Hurt")
# 	animated_sprite.animation_finished.connect(idle, CONNECT_ONE_SHOT)

# func handleDeathAnimation() -> void:
# 	animated_sprite.play("Death")
