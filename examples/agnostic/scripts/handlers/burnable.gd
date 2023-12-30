extends Node

@export_node_path("Node2D", "Node3D")
var __effect
@onready
var _effect = get_node(__effect) if __effect else null

@export_node_path("Hurtbox3D", "Hurtbox2D")
var __hurtbox
@onready
var _hurtbox = get_node(__hurtbox)

@export
var _buff_handler: BuffHandler

func _ready() -> void:
	_buff_handler.buff_applied.connect(_on_buff_applied)
	_buff_handler.buff_ended.connect(_on_buff_ended)
	_hurtbox.triggered.connect(_on_hurtbox_hit)
	
	if _effect:
		_effect.hide()

func _on_buff_applied(buff: Buff) -> void:
	buff = buff as BuffTickDamage
	if not buff:
		return
	
	buff.apply_damage.connect(_on_damage)
	if _effect:
		_effect.show()

func _on_buff_ended(buff: Buff) -> void:
	buff = buff as BuffTickDamage
	if not buff:
		return
	
	if _effect:
		_effect.hide()

func _on_damage(damage: int) -> void:
	var data := HitData.new()
	data.damage = damage
	_hurtbox.trigger(data, self)

func _on_hurtbox_hit(hit_data: HitData) -> void:
	if hit_data.hitter == self:
		return
	if not "burn" in hit_data.flags:
		return
	
	hit_data = hit_data as HitDataTickDamage
	if not hit_data:
		return
	
	_buff_handler.apply_buff(BuffTickDamage.new(hit_data.duration, hit_data.damage, hit_data.period))
