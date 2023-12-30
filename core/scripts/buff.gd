extends Node
class_name Buff
## Base class for buffs/debuffs, to be used with BuffHandler

signal over(_self)
signal start_flash

var _timer: Timer

var icon: Texture2D

## Duration after which the buff will die out, 0.0 for infinite (until removed)
var duration: float = 0.0

var ui_flash_duration: float = 2.0

var emitted_flash: bool = false

func _ready() -> void:
	_timer = Timer.new()
	_timer.autostart = false
	_timer.one_shot = true
	add_child(_timer)
	_timer.timeout.connect(_timeout)

func _process(delta: float) -> void:
	if not emitted_flash:
		if _timer.time_left <= ui_flash_duration:
			start_flash.emit()
			emitted_flash = true

func _init(duration: float) -> void:
	self.duration = duration

func restart() -> void:
	start()
	emitted_flash = false

func start() -> void:
	if duration > 0.0:
		_timer.start(duration)

func get_icon() -> Texture2D:
	return icon

func _timeout() -> void:
	over.emit(self)
