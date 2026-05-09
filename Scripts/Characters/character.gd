extends Node

class_name Character

@export var ui_manager: UiManager

var health = 100
var shield = 0


# @export var healthBar: HealthBar


# enum ACTION_TYPE {SWORD, ARROW, SHIELD, NONE}

func on_hit(damage: int) -> void:
	health -= damage
	ui_manager.update_current_hp(health)
	

# func onAddShield(shieldValue: int) -> void:
# 	shield += shieldValue
# 	print("Gain block! Current shield: %d" % shield)


# #-------------------------------------------------------------------------------------
# ## Animation Handlers

# func handleHurtAnimation() -> void:
# 	# Placeholder for hurt animation logic
# 	pass

# func handleAttackAnimation() -> void:
# 	# Placeholder for attack animation logic
# 	pass

# func handleDeathAnimation() -> void:
# 	# Placeholder for death animation logic
# 	pass
