extends Control
class_name UiManager

@export var health_bar: TextureProgressBar

# HEALTH BAR
func update_current_hp(current:int)-> void:
	health_bar.value = current

func update_max_hp(current:int)-> void:
	health_bar.max_value = current