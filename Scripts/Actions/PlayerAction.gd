extends Action
class_name PlayerAction

var player: Player

var player_action_map: Dictionary[String, Variant] = {
	"basic_attack": { "value": 10, "action_type":ActionType.ATTACK, "action_point": 2, "description": "Honestly you can do better..."},
	"heavy_attack": { "value": 30, "action_type":ActionType.ATTACK, "action_point": 5, "description": "Damn bro, you're not kidding"},
	"guard": { "value": 10,"action_type":ActionType.PROTECTION, "action_point": 3, "description": "Ok ok you're a big guy, i get it"},
	"provocation": { "value": 30,"action_type":ActionType.PROVOCATION, "action_point": 4, "description": "You're so annoying, If i could i would hit you too"},

}

func _init(_player: Player)->void:
	player = _player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func apply_action(action_key: String, target: Character)->void:
	var action = player_action_map[action_key]
	if(player.action_points >= action.action_point):
		match action.action_type:
			ActionType.ATTACK:
				target.on_hit(action.value)
				player.action_points -= action.action_point
			ActionType.DEBUFF:
				pass
			ActionType.BUFF:
				pass
			ActionType.PROTECTION:
				pass
			ActionType.PROVOCATION:
				pass
	else:
		print("player %d don't have enough mana for action" % [player.player_index])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
