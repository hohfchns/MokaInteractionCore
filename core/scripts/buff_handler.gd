extends Node
class_name BuffHandler

signal buff_applied(buff)
signal buff_refreshed(buff)
## Warning - Buff will be queue_free'd
signal buff_ended(buff)

## Applies / Reapplies a buff, warning - consumes the buff!
func apply_buff(buff: Buff) -> void:
	for child in get_children():
		if not child is Buff:
			continue
		
		if typeof(child) == typeof(buff):
			child.restart()
			buff_refreshed.emit(child)
			return
	
	buff.over.connect(_on_buff_over)
	add_child(buff)
	buff.start()
	buff_applied.emit(buff)
	return

func get_buff(type: int) -> Buff:
	for child in get_children():
		if typeof(child) == type:
			return child
	
	return null

func _on_buff_over(buff) -> void:
	buff_ended.emit(buff)
	buff.queue_free()


