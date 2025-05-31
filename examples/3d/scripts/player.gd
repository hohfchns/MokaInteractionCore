extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@export_group("Required Nodes")
@export
var _head_axis: Node3D

@export
var _sensitivity: float = 0.0015

@export
var _fireball: PackedScene

@export
var _fireball_velocity: float = 10.0

@onready
var _hit_ray: MKHitRay3D = $Head/Hitray3D

func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity.y = 0.0
	else:
		if velocity.y > 0.0:
			velocity.y -= gravity * delta
		else:
			velocity.y -= gravity * 2 * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("burn"):
		if not _hit_ray.try_hit():
			var inst := _fireball.instantiate() as RigidBody3D
			get_parent().add_child(inst)
			inst.global_transform = _head_axis.global_transform
			var inst_forward: Vector3 = -(_head_axis.get_global_transform().basis.z).normalized()
			inst.position += inst_forward
			inst.apply_impulse(inst_forward * _fireball_velocity)

func _input(event: InputEvent) -> void:
	event = event as InputEventMouseMotion
	if event == null:
		return
	
	if DisplayServer.mouse_get_mode() not in [DisplayServer.MOUSE_MODE_CAPTURED, DisplayServer.MOUSE_MODE_HIDDEN, DisplayServer.MOUSE_MODE_CONFINED_HIDDEN]:
		return
	
	var x: float = event.relative.x
	var y: float = event.relative.y
	
	_head_axis.rotation.x = clampf(_head_axis.rotation.x - y * _sensitivity, deg_to_rad(-90), deg_to_rad(90))
	rotation.y -= x * _sensitivity
