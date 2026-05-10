extends Node
class_name GameStatusManager

@export var victory_screen: ColorRect
@export var death_screen: ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func toggle_death_screen()->void:
	death_screen.visible = !death_screen.visible

func toggle_victory_screen()->void:
	victory_screen.visible = !victory_screen.visible
