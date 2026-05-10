extends Node

class_name Character

@export var ui_manager: UiManager

@export var health = 100
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

func hurt_anim()->void:
	pass
