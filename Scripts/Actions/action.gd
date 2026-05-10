extends Node
class_name Action

enum ActionType {
	ATTACK,
	DEBUFF,
	BUFF,
	PROTECTION,
	PROVOCATION
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func apply_action(action_key: String, target: Character)->void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
