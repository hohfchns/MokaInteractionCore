extends Area3D
class_name Hurtbox3D

signal triggered(hit_data: HitData)

@export
var ignore_groups: Array[StringName]

func trigger(hit_data: HitData, hitter: Node) -> bool:
	for group in ignore_groups:
		if hitter.is_in_group(group):
			return false
	
	var new_data := hit_data.duplicate()
	new_data.hitter = hitter
	triggered.emit(new_data)
	return true
