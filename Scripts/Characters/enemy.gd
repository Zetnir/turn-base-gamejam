extends Character

class_name Enemy

@export var animated_sprite: AnimatedSprite2D
@export var damage = 5

func _ready() -> void:
	if animated_sprite:
		animated_sprite.play("idle")
	health = 50
