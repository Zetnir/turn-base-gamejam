extends ProgressBar

class_name HealthBar

func _ready() -> void:
    value = 100

func update_health(new_health: int) -> void:
    value = new_health