extends Node
# MUSIC export
@export var victory_music: AudioStreamPlayer2D
@export var defeat_music: AudioStreamPlayer2D
@export var heavy_attack_sfx: AudioStreamPlayer2D
@export var basic_attack_sfx: AudioStreamPlayer2D

# SFX export


# MUSIC functions called
func play_victory() -> void:
	_stop_all_music()
	victory_music.play()

func play_defeat() -> void:
	_stop_all_music()
	defeat_music.play()

# SFX functions called

func process_action_sound(action_key: String, pos: Vector2)-> void:
	match action_key:
		"heavy_attack": play_heavyAtk_sfx(pos)
		"basic_attack": play_basicAtk_sfx(pos)

func play_heavyAtk_sfx(target_position: Vector2) -> void: 
	heavy_attack_sfx.global_position = target_position
	heavy_attack_sfx.stop()
	heavy_attack_sfx.play()
	
func play_basicAtk_sfx(target_position: Vector2) -> void: 
	basic_attack_sfx.global_position = target_position
	basic_attack_sfx.stop()
	basic_attack_sfx.play()


func _stop_all_music() -> void: 
	victory_music.stop()
	defeat_music.stop()
	MusicBgm.stop()
	
	
func _stop_all_sfx() -> void: 
	heavy_attack_sfx.stop()
	basic_attack_sfx.stop()
