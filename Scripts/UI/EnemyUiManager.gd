extends UiManager

@export var attack_icon: TextureRect
@export var defense_icon: TextureRect
@export var debuff_icon: TextureRect

enum ActionType { ATTACK, DEFENSE, DEBUFF }

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hide_all_action_icons()

func show_action_type_prediction(level: ActionType) -> void:
	match level: 
		ActionType.ATTACK: attack_icon.visible = true
		ActionType.DEFENSE: defense_icon.visible = true
		ActionType.DEBUFF: debuff_icon.visible = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func hide_action_prediction() -> void:
	_hide_all_action_icons()
	
func _hide_all_action_icons() -> void:
	attack_icon.visible = false
	defense_icon.visible = false
	debuff_icon.visible = false
