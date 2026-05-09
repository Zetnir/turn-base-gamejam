extends Node

class_name Character

@export var healthBar: HealthBar

var health = 100
var shield = 0

enum ACTION_TYPE {SWORD, ARROW, SHIELD, NONE}

func onHit(damage: int) -> void:
	health -= damage
	healthBar.update_health(health)
	print("Target hit! Current health: %d" % health)
	if health <= 0:
		handleDeathAnimation()
		return 
	handleHurtAnimation()
	

func onAddShield(shieldValue: int) -> void:
	shield += shieldValue
	print("Gain block! Current shield: %d" % shield)


#-------------------------------------------------------------------------------------
## Animation Handlers

func handleHurtAnimation() -> void:
	# Placeholder for hurt animation logic
	pass

func handleAttackAnimation() -> void:
	# Placeholder for attack animation logic
	pass

func handleDeathAnimation() -> void:
	# Placeholder for death animation logic
	pass
