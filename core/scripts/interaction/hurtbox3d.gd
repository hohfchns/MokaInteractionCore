extends Area3D
class_name Hurtbox3D

signal triggered(hit_data: HitData)

@export
var ignore_groups: Array[StringName]

var __disable_defer: int = -1 

func trigger(hit_data: HitData, hitter: Node) -> bool:
	for group in ignore_groups:
		if hitter.is_in_group(group):
			return false
	
	var new_data := hit_data.make_copy()
	new_data.hitter = hitter
	triggered.emit(new_data)
	return true

func disable() -> void:
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	__disable_defer = 1
	set_deferred("__disable_defer", -1)

func enable() -> void:
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
	__disable_defer = 0
	set_deferred("__disable_defer", -1)

func disabled() -> bool:
	if __disable_defer == 1:
		return true
	if __disable_defer == 0:
		return false
	
	return not monitoring and not monitorable
