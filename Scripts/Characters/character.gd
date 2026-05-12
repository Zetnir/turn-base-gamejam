extends Node
class_name Character

@export var ui_manager: UiManager
@export var stats: CharacterData
@export var animated_sprite: AnimatedSprite2D
@export var vfx_manager: VfxManager
@export var audio_manager: Node


var health: float = 0.0
var debuff_attack_timer = 0
var debuff_defense_timer = 0
var shield_timer = 0
var power_percent: float = 100.0
var defense_percent: float = 0.0
var shield = 0
var is_dead = false

func _ready():
	if stats != null and stats.resource_path != "":
		var fresh := ResourceLoader.load(stats.resource_path, "", ResourceLoader.CACHE_MODE_IGNORE) as CharacterData
		if fresh:
			stats = fresh

	if stats == null:
		push_warning(name + ": stats is null, using defaults")
		stats = CharacterData.new()

	health = stats.max_health
	power_percent = stats.base_power_percent
	defense_percent = stats.base_defense_percent
	ui_manager.update_max_hp(int(stats.max_health))
	ui_manager.update_current_hp(health)

func on_hit(damage: int) -> void:
	if shield > 0:
		shield -= damage * (1 - defense_percent/ 100)
		if shield <= 0:
			var damage_supp = shield
			shield = 0
			health -= damage_supp
			ui_manager.update_current_hp(health)

		ui_manager.update_shield_point(shield)
	else:
		health -= damage * (1 - defense_percent/ 100)
		ui_manager.update_current_hp(health)

	if health <= 0:
		death_anim()
	else:
		hurt_anim()
		await get_tree().create_timer(0.02).timeout
		if vfx_manager:
			vfx_manager.play_hit(self.position)


func on_debuff_attack(percent_reduc: int)->void:
	power_percent -= percent_reduc
	debuff_attack_timer = 1
	if vfx_manager:
		vfx_manager.play_atk_debuff(self.position)

func on_debuff_defense(percent_reduc: int)->void:
	defense_percent -= percent_reduc
	debuff_defense_timer = 1
	if vfx_manager:
		vfx_manager.play_def_debuff(self.position)

func on_protection(block: int)->void:
	shield += block
	shield_timer = 1
	ui_manager.update_shield_point(shield)
	if vfx_manager:
		vfx_manager.play_guard(self.position)
	
func reduce_timers()->void:
	## Debuff Attack
	if debuff_attack_timer > 0:
		debuff_attack_timer -= 1
		if debuff_attack_timer >= 0:
			power_percent = stats.base_power_percent

	## Debuff Defense
	if debuff_defense_timer > 0:
		debuff_defense_timer -= 1
		if debuff_defense_timer >= 0:
			defense_percent = stats.base_defense_percent
	
	## Shield
	if shield_timer > 0:
		shield_timer -= 1
		if shield_timer >= 0:
			shield = 0
			ui_manager.update_shield_point(shield)



# func onAddShield(shieldValue: int) -> void:
# 	shield += shieldValue
# 	print("Gain block! Current shield: %d" % shield)


# #-------------------------------------------------------------------------------------
# ## Animation Handlers

func idle_anim()->void:
	animated_sprite.play("idle")

func play_action_anim(animation_key: String)->void:
	if not animated_sprite.sprite_frames.has_animation(animation_key):
		return
	if animated_sprite.animation_finished.is_connected(idle_anim):
		animated_sprite.animation_finished.disconnect(idle_anim)
	animated_sprite.stop()
	animated_sprite.play(animation_key)
	animated_sprite.animation_finished.connect(idle_anim, CONNECT_ONE_SHOT)

func hurt_anim()->void:
	if animated_sprite.animation_finished.is_connected(idle_anim):
		animated_sprite.animation_finished.disconnect(idle_anim)
	animated_sprite.play("hurt")
	animated_sprite.animation_finished.connect(idle_anim, CONNECT_ONE_SHOT)

func death_anim()->void:
	animated_sprite.play("death")
