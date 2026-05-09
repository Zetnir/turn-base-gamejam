extends Button
class_name CombatButton

@export var normal_texture: Texture2D
@export var focus_texture: Texture2D

func _ready():
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)

func _on_focus_entered():
	pass

func _on_focus_exited():
	pass

func _pressed() -> void:
	emit_signal("pressed")
