extends Control
class_name EnemySelectionPanel 

@export var enemiesPos: Array[Button]

signal enemy_selected(index)

func _ready() -> void:
	for i in range(enemiesPos.size()):
		enemiesPos[i].connect("pressed", on_enemy_selected.bind(i))

func toggle_display_panel () -> void:
	self.visible = !self.visible
	print("visible: ", self.visible)

	if(self.visible):
		enemiesPos[0].grab_focus()
	pass

func on_enemy_selected(index: int) -> void:
	print("Enemy %d selected" % index)
	emit_signal("enemy_selected", index)
