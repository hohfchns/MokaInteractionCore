extends MKAHitter
class_name MKHitbox2D

@export
var _actor: Area2D


func _ready() -> void:
	actor().area_entered.connect(_area_entered)

func actor() -> Area2D:
	return _actor

func _enable() -> void:
	if not actor().is_inside_tree():
		await actor().tree_entered
	
	for c in actor().get_children():
		if c is CollisionShape2D:
			c.disabled = false

func _disable() -> void:
	if not actor().is_inside_tree():
		await actor().tree_entered
	
	for c in actor().get_children():
		if c is CollisionShape2D:
			c.disabled = true
