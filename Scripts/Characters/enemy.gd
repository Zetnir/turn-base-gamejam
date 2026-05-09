extends Character

class_name Enemy

@export var animated_sprite: AnimatedSprite2D
@export var damage = 5

func _ready() -> void:
	if animated_sprite:
		animated_sprite.play("Idle")
	health = 50

func handleHurtAnimation() -> void:
	if animated_sprite:
		animated_sprite.play("Hurt")
		animated_sprite.animation_finished.connect(idle, CONNECT_ONE_SHOT)

func handleAttackAnimation() -> void:
	if animated_sprite:
		animated_sprite.play("Attack")

func handleDeathAnimation() -> void:
	if animated_sprite:
		animated_sprite.play("Death")

func idle() -> void:
	if animated_sprite:
		animated_sprite.play("Idle")

func attack(target: Character) -> void:
	handleAttackAnimation()
	var afterAnimation = func ()->void:
		target.onHit(damage)
		idle()
	animated_sprite.animation_finished.connect(afterAnimation, CONNECT_ONE_SHOT)
