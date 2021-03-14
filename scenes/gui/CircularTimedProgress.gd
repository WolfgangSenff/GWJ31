extends TextureProgress

signal is_refreshed

export (int) onready var TimeToRefresh setget set_refresh_time

onready var timer = $Timer

var is_ready = true

func _ready() -> void:
	timer.connect("timeout", self, "_on_timer_timeout")
	set_refresh_time(TimeToRefresh)
	
# Have a separate function in case we want a room which can
#  reduce these timers globally or something.
func set_refresh_time(time) -> void:
	max_value = time
	TimeToRefresh = time
	
func begin_refresh() -> void:
	is_ready = false
	value = max_value
	show()
	timer.start()
	
func _on_timer_timeout() -> void:
	value -= 1
	if value <= 0:
		is_ready = true
		timer.stop()
		hide()
		emit_signal("is_refreshed")
