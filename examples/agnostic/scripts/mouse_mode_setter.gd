extends Node

@export
var _enabled := true

@export
var _mode: DisplayServer.MouseMode

func _ready() -> void:
	if _enabled:
		DisplayServer.mouse_set_mode(_mode)
