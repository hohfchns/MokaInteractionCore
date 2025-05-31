extends Node2D

@export_group("Required Nodes")
@export
var _hurtbox: MKAHurtbox

@export_group("Parameters")
@export
var _multiplier: float = 1.0

@export_group("Optional Nodes")
@export
var _custom_target: Node2D

@onready
var _target: Node2D = get_parent()

func _ready() -> void:
	_hurtbox.triggered.connect(_on_hit)
	
	if _custom_target:
		_target = _custom_target

func _on_hit(hit_data: MKHitData) -> void:
	var hit_vector: Vector2 = hit_data.knockback_direction * hit_data.knockback_force
	if "velocity" in _target:
		_target.velocity += hit_vector * _multiplier
		return
	
	_target.position += hit_vector * _multiplier
