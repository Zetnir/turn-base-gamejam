extends Action
class_name PlayerAction

var player: Player
@export var audio_manager: Node
@export var player_action_map: Dictionary[String, Variant] = {
	"basic_attack": { "damage": 10, "action_type":ActionType.ATTACK, "action_point": 2, "anim":"basicAttack", "description": "Honestly you can do better..."},
	"heavy_attack": { "damage": 30, "action_type":ActionType.ATTACK, "action_point": 5, "anim":"heavyAttack", "description": "Damn bro, you're not kidding"},
	"guard": { "block": 10,"action_type":ActionType.PROTECTION, "action_point": 3, "anim":"guard", "description": "Ok ok you're a big guy, i get it"},
	"provocation": { "percentAggro": 30,"action_type":ActionType.PROVOCATION, "action_point": 4, "anim":"provocation", "description": "You're so annoying, If i could i would hit you too"},
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent()
	print(player.name)

func apply_action(action_key: String, target: Character)->void:
	var action = player_action_map.get(action_key)
	if(player.action_points >= action.action_point):
		match action.action_type:
			ActionType.ATTACK:
				print("player:", player.name)
				player.consume_action_points(action.action_point)
				player.play_action_anim(action.anim)
				player.audio_manager.process_action_sound(action_key,player.position)
				await player.get_tree().create_timer(.5).timeout
				target.on_hit(action.damage)
			ActionType.ATK_DEBUFF:
				pass
			ActionType.DEF_DEBUFF:
				pass
			ActionType.BUFF:
				pass
			ActionType.PROTECTION:
				player.consume_action_points(action.action_point)
				player.play_action_anim(action.anim)
				await player.get_tree().create_timer(.5).timeout
				player.on_protection(action.block)

				# player.consume_action_points(action.action_point)
				# player.play_action_anim(action.anim)
				# await player.get_tree().create_timer(.5).timeout
				# target.on_hit(action.block)
			ActionType.PROVOCATION:
				pass
				# player.consume_action_points(action.action_point)
				# player.play_action_anim(action.anim)
				# await player.get_tree().create_timer(.5).timeout
				# target.on_hit(action.percentAggro)
	else:
		print("player %d don't have enough mana for action" % [player.player_index])
