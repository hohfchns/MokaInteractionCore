extends Node
class_name MKAHitter

signal hurtbox_detected(hurtbox: MKAHurtbox)
signal enabled_changed(to: bool)

@export
var hit_data: MKHitData

@export
var ignore_groups: Array[StringName]

var enabled: bool = true :
	set = set_enabled,
	get = get_enabled


func _ready() -> void:
	assert(false, "Abstract class must be overriden")

func actor() -> Node:
	assert(false, "Abstract class must be overriden")
	return null

func _area_entered(area: Node) -> bool:
	if area is not MKAHurtbox:
		return false
	
	for group in ignore_groups:
		if area.is_in_group(group) \
		or group in area.ignore_groups:
			return false
	
	if ( area.trigger(hit_data, self) ):
		hurtbox_detected.emit(area)
		return true
	
	return false

func _enable() -> void:
	assert(false, "Abstract class must be overriden")

func _disable() -> void:
	assert(false, "Abstract class must be overriden")

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
