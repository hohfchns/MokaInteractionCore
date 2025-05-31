extends RigidBody2D

@export_group("Required Nodes")
@export
var _hitbox: MKHitbox2D

func _ready() -> void:
	_hitbox.hurtbox_detected.connect(queue_free)

func _process(delta: float) -> void:
	_hitbox.hit_data.knockback_direction = linear_velocity.normalized()
