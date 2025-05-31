extends Node
class_name MKAHurtbox

signal triggered(hit_data: MKHitData)
signal enabled_changed(to: bool)

@export
var ignore_groups: Array[StringName]

var enabled: bool = true :
	set = set_enabled,
	get = get_enabled


func trigger(hit_data: MKHitData, hitter: Node) -> bool:
	for group in ignore_groups:
		if hitter.is_in_group(group):
			return false
	
	var new_data := hit_data.make_copy()
	new_data.hitter = hitter
	triggered.emit(new_data)
	return true

func _enable() -> void:
	if not is_inside_tree():
		await tree_entered
	
	for c in get_children():
		if c is CollisionShape3D:
			c.disabled = false

func _disable() -> void:
	if not is_inside_tree():
		await tree_entered
	
	for c in get_children():
		if c is CollisionShape3D:
			c.disabled = true

func set_enabled(value: bool) -> void:
	if enabled == value:
		return
	
	if value:
		_enable()
	else:
		_disable()
	
	enabled = value
	enabled_changed.emit(enabled)

func get_enabled() -> bool:
	return enabled
