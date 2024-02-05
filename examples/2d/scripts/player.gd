extends CharacterBody2D

@export
var max_speed := 300.0
@export
var __acceleration_sec := 0.1
@export
var __decceleration_sec := 0.1

@export
var _fireball: PackedScene
@export
var _burn_hit_data: HitData
@export
var _fireball_velocity: float = 600.0

@onready
var acceleration = max_speed / __acceleration_sec
@onready
var decceleration = max_speed / __decceleration_sec

@onready
var _raycast: RayCast2D = $RayCast2D

var _last_move_dir: Vector2 = Vector2(1, 0)

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	if direction:
		velocity = velocity.move_toward(max_speed * direction, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, decceleration * delta)
	
	if direction:
		_last_move_dir = Vector2(1, 0) # Reset to default value
		if direction.x > 0:
			_last_move_dir.x = 1
		elif direction.x < 0:
			_last_move_dir.x = -1
		if direction.y > 0:
			_last_move_dir.y = 1
		elif direction.y < 0:
			_last_move_dir.y = -1
	
	move_and_slide()
	
	if Input.is_action_just_pressed("burn"):
		var collider := _raycast.get_collider() as Hurtbox2D
		if collider:
			_burn_hit_data.knockback_direction = global_position.direction_to(collider.global_position)
			collider.trigger(_burn_hit_data, _raycast)
		else:
			var inst := _fireball.instantiate() as RigidBody2D
			inst.global_transform = self.global_transform
			inst.position += _last_move_dir * 100
			inst.apply_impulse(_last_move_dir * _fireball_velocity)
			get_parent().add_child(inst)
