extends UiManager

@export var light_damage_icon: TextureRect
@export var medium_damage_icon: TextureRect
@export var high_damage_icon: TextureRect
@export var very_high_damage_icon: TextureRect

enum DamageLevel { NONE, LIGHT, MEDIUM, HIGH, VERY_HIGH }
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hide_all_damage_icons()
	
func show_dmg_prediction(level: DamageLevel) -> void:
	match level: 
		DamageLevel.LIGHT: light_damage_icon.visible = true
		DamageLevel.MEDIUM: medium_damage_icon.visible = true
		DamageLevel.HIGH: high_damage_icon.visible = true
		DamageLevel.VERY_HIGH: very_high_damage_icon.visible = true
		 
func hide_damage_prediction() -> void:
	_hide_all_damage_icons()
	
func _hide_all_damage_icons() -> void:
	light_damage_icon.visible = false
	medium_damage_icon.visible = false
	high_damage_icon.visible = false
	very_high_damage_icon.visible = false
