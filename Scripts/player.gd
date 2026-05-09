extends Character

class_name Player

@export var animated_sprite: AnimatedSprite2D
@export var multiplayerCursorNavigation: MultiplayerCursorNavigation
@export var playerIndex: int = 0

var basicAction = ACTION_TYPE.SWORD
var strongAction = ACTION_TYPE.ARROW
var defenseAction = ACTION_TYPE.SHIELD

var canPlay = false


func _ready() -> void:
	if animated_sprite && !animated_sprite.is_playing():
		animated_sprite.play("Idle")


func _input(event):
	if canPlay && health > 0:
		if event.is_action_pressed("p%d_basic" % (playerIndex + 1)):
			multiplayerCursorNavigation.trigger_player_navigation(playerIndex, basicAction)
			pass
		if event.is_action_pressed("p%d_strong" % (playerIndex + 1)):
			multiplayerCursorNavigation.trigger_player_navigation(playerIndex, strongAction)
			pass
		if event.is_action_pressed("p%d_defense" % (playerIndex + 1)):
			multiplayerCursorNavigation.trigger_player_navigation(playerIndex, defenseAction)
			pass


#-------------------------------------------------------------------------------------
## Player Actions 

func process_action(action: Character.ACTION_TYPE, target: Character) -> void:
	var playerAction = PlayerAction.new(self)
	match action:
		Character.ACTION_TYPE.SWORD:
			playerAction.SwordAttack(target)
			pass
		Character.ACTION_TYPE.ARROW:
			playerAction.ArrowAttack(target)
			pass
		Character.ACTION_TYPE.SHIELD:
			playerAction.ShieldBlock(target)
			pass
		Character.ACTION_TYPE.NONE:
			pass




# func handle_player_inputs() -> void:
# 	pass , 

	# if Input.is_action_just_pressed("basic_attack"):
	# 	basic_attack()
	# if Input.is_action_just_pressed("strong_attack"):
	# 	strong_attack()
	
	# enemySelectionPanel.enemy_selected.connect(confirm_attack)
	# if Input.is_action_just_pressed("confirm") && isSelectingTarget:
	# 	confirm_attack()

	#-----------------------------------------------------------------------------------

# func basic_attack() -> void:
# 	actionType = ACTION_TYPE.BASIC_ATTACK
# 	if(enemySelectionPanel):
# 		toggleSelection()
		
# func strong_attack() -> void:
# 	actionType = ACTION_TYPE.STRONG_ATTACK
# 	if(enemySelectionPanel):
# 		toggleSelection()
	
# func toggleSelection() -> void:
# 		enemySelectionPanel.toggle_display_panel()
# 		isSelectingTarget = !isSelectingTarget

# func onHit(damage: int) -> void:
# 	health -= damage
# 	healthBar.update_health(health)
# 	print("Player hit! Current health: %d" % health)
	
# func confirm_attack(index: int) -> void:
# 	match actionType:
# 		ACTION_TYPE.BASIC_ATTACK:
# 			start_basic_attack_anim()
# 			pass
# 		ACTION_TYPE.STRONG_ATTACK:
# 			start_strong_attack_anim()
# 			pass
# 		ACTION_TYPE.DEFENSE:
# 			pass
# 		ACTION_TYPE.NONE:
# 			pass
# 	toggleSelection()
	

#-----------------------------------------------------------------------------------
## Animation Handlers

func idle() -> void:
	animated_sprite.play("Idle")
	
func handleHurtAnimation() -> void:
	animated_sprite.play("Hurt")
	animated_sprite.animation_finished.connect(idle, CONNECT_ONE_SHOT)

func handleDeathAnimation() -> void:
	animated_sprite.play("Death")