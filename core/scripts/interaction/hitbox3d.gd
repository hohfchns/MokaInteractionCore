extends MKAHitter
class_name MKHitbox3D

@export
var area: Area3D


func _ready() -> void:
	actor().area_entered.connect(_area_entered)

func actor() -> Area3D:
	return area

func _enable() -> void:
	if not actor().is_inside_tree():
		await actor().tree_entered
	
	for c in actor().get_children():
		if c is CollisionShape3D:
			c.disabled = false

func _disable() -> void:
	if not actor().is_inside_tree():
		await actor().tree_entered
	
	for c in actor().get_children():
		if c is CollisionShape3D:
			c.disabled = true
