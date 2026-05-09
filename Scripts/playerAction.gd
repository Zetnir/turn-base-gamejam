extends Node

class_name PlayerAction

var player: Player

func _init(_player: Player) -> void:
	player = _player

#-------------------------------------------------------------------------------------
## Action Implementations

func SwordAttack(target: Character) -> void:
	var damage = 10
	player.canPlay = false
	player.animated_sprite.play("Attack")

	var afterAnimation = func ()->void:
		target.onHit(damage)
		player.idle()
		player.canPlay = true

	player.animated_sprite.animation_finished.connect(afterAnimation, CONNECT_ONE_SHOT)


func ArrowAttack(target: Character) -> void:
	var damage = 15
	player.animated_sprite.play("Arrow")
	player.canPlay = false

	var afterAnimation = func ()->void:
		target.onHit(damage)
		player.idle()
		player.canPlay = true

	player.animated_sprite.animation_finished.connect(afterAnimation, CONNECT_ONE_SHOT)


func ShieldBlock(target: Character) -> void:
	var shieldValue = 5
	target.onAddShield(shieldValue)
