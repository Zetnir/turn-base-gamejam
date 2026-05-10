extends Control
class_name UiManager

@export var health_bar: TextureProgressBar
@export var health_point_current: Label
@export var shield_icon: TextureRect
@export var shield_point_current: Label

# HEALTH BAR
func update_current_hp(current:int)-> void:
	health_point_current.text = str(current)
	health_bar.value = current
	
func update_max_hp(current:int)-> void:
	health_bar.max_value = current
	
# SHIELD BLOCK POINTS
func update_shield_point(current:int)-> void:
	shield_point_current.text = str(current)
	
func show_shield_icon() -> void: 
	shield_icon.visible = true
	
func _hide_shield_icon() -> void:
	shield_icon.visible = false
