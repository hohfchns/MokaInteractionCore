extends Node

@export
var _signal: StringName
@export
var _from_node: Node
@export
var _to_node: Node
@export
var _to_function: StringName

@export_range(0, 15)
var _discard_arguments: int = 0

func _ready() -> void:
	var _to_function := _to_node.get(_to_function) as Callable
	if _discard_arguments:
		_to_function = _to_function.unbind(_discard_arguments)
	
	_from_node.connect(_signal, _to_function)
