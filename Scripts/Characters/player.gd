extends Character

class_name Player

@export var multiplayer_cursor_navigator: MultiplayerCursorNavigator

@export var animated_sprite: AnimatedSprite2D

@export var player_index: int = 0

# var basic_action = ACTION_TYPE.SWORD
# var strong_action = ACTION_TYPE.ARROW
# var defense_action = ACTION_TYPE.SHIELD

# var canPlay = false


func _ready() -> void:
	if animated_sprite && !animated_sprite.is_playing():
		animated_sprite.play("idle")


func _input(event):
	if event.is_action_pressed("P%d_ACTION_1" % (player_index + 1)):
		## TODO : Handle Action list and pass action index depending on input
		multiplayer_cursor_navigator.trigger_player_navigation(player_index, 0)


# #-------------------------------------------------------------------------------------
# ## Player Actions 

func process_action(action_index: int, target: Character) ->void:
	print("player %d, process action %d, target %s" % [player_index, action_index, target.name])

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
