extends Buff
class_name BuffTickDamage

var damage: int = 1
var tick_duration: float = 0.1
var tick_catch_up := true

signal apply_damage(damage: int)

var _tick: float = 0.0

func _process(delta: float) -> void:
	super._process(delta)
	
	_tick += delta
	if _tick >= tick_duration:
		apply_damage.emit(damage)
		if tick_catch_up:
			_tick -= tick_duration
		else:
			_tick = 0.0

func _init(duration: float, damage: int, tick_duration: float):
	super._init(duration)
	
	self.damage = damage
	self.tick_duration = tick_duration
