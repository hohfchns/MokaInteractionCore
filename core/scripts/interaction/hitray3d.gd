extends MKAHitter
class_name MKHitRay3D

@export
var _ray: RayCast3D

func _ready() -> void:
	pass

func actor() -> RayCast3D:
	return _ray

func _enable() -> void:
	_ray.enabled = true

func _disable() -> void:
	_ray.enabled = false

func try_hit() -> MKAHurtbox:
	var collider := actor().get_collider()
	var hurtbox := collider as MKAHurtbox
	if hurtbox:
		if _area_entered(hurtbox):
			return hurtbox
	return null
