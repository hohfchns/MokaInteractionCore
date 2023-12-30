extends Area2D
class_name Hitbox2D

signal hurtbox_detected(hurtbox: Hurtbox2D)

@export
var hit_data: HitData

@export
var ignore_groups: Array[StringName]

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox2D:
		for group in ignore_groups:
			if area.is_in_group(group):
				return
		
		if ( area.trigger(hit_data, self) ):
			hurtbox_detected.emit(area)

func disable() -> void:
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)

func enable() -> void:
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)

func disabled() -> bool:
	return monitoring and monitorable

