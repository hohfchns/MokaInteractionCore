extends Buff
class_name BuffDamageMultiply

var multiplier: float = 1.0
var is_debuff := false

func _ready() -> void:
	super._ready()

func _init(duration: float, multiplier: float):
	super._init(duration)
	self.multiplier = multiplier

func get_icon() -> Texture2D:
	return null
