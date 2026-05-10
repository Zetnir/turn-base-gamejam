extends Character

class_name Enemy

@export var animated_sprite: AnimatedSprite2D

func _ready() -> void:
	if animated_sprite:
		idle_anim()

# #-------------------------------------------------------------------------------------
# ## Enemy Actions and AI

func process_action(players: Array[Player])-> void:
	var action = choose_action(players)
	var target = choose_target(players)
	

## TODO : Choose ActionType based 
func choose_action(players: Array[Player])->EnemyAction:
	var enemy_action: EnemyAction
	return enemy_action

func choose_target(players: Array[Player])->Player:
	var player: Player
	return player

# #-------------------------------------------------------------------------------------
# ## Enemy Animations

func idle_anim()->void:
	animated_sprite.play("idle")

func hurt_anim()->void:
	animated_sprite.play("hurt")
	animated_sprite.animation_finished.connect(idle_anim, CONNECT_ONE_SHOT)
