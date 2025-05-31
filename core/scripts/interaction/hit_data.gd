extends Resource
class_name MKHitData

## This data should be (more or less) constant for the HitData object, it is it's definition
#region Data
@export
var damage: int = 1

@export
var knockback_force: float = 0.0

@export
var flags: Array[StringName]

@export
var metadata: Dictionary
#endregion

## This data should be set when using/providing the HitData object
#region Runtime Data
var hitter: Node
var knockback_direction: Vector2
#endregion

## By default duplicate does not copy non-exported properties, so we define our own copy
func make_copy(subresources: bool = false) -> MKHitData:
	var new_data: MKHitData = super.duplicate(subresources)
	
	new_data.hitter = hitter
	new_data.knockback_direction = knockback_direction
	
	return new_data
