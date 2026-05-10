extends Node2D
class_name VfxManager

@export var vfx_sprite_2d_01: AnimatedSprite2D
@export var vfx_sprite_2d_02: AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hide_all()


# VFX PLAY
func play_hit(target_position: Vector2) -> void:
	global_position = target_position
	vfx_sprite_2d_01.visible = true
	vfx_sprite_2d_01.play("hit")
	await vfx_sprite_2d_01.animation_finished
	vfx_sprite_2d_01.visible = false
	
	
func play_atk_debuff(target_position: Vector2) -> void:
	global_position = target_position
	vfx_sprite_2d_01.visible = true
	vfx_sprite_2d_01.play("atkDebuff")
	await vfx_sprite_2d_01.animation_finished
	vfx_sprite_2d_01.visible = false
	
	
func play_def_debuff(target_position: Vector2) -> void:
	global_position = target_position
	vfx_sprite_2d_01.visible = true
	vfx_sprite_2d_01.play("defDebuff")
	await vfx_sprite_2d_01.animation_finished
	vfx_sprite_2d_01.visible = false
	
	
func play_guard(target_position: Vector2) -> void:
	global_position = target_position
	vfx_sprite_2d_01.visible = true
	vfx_sprite_2d_01.play("guard")
	await vfx_sprite_2d_01.animation_finished
	vfx_sprite_2d_01.visible = false
	
	
func play_provocation(target_position: Vector2) -> void:
	global_position = target_position
	vfx_sprite_2d_02.visible = true
	vfx_sprite_2d_02.play("provocation")
	await vfx_sprite_2d_02.animation_finished
	vfx_sprite_2d_02.visible = false
	
# HIDE ALL VFX SPRITES
func _hide_all() -> void:
	vfx_sprite_2d_01.visible = false
	vfx_sprite_2d_02.visible = false
