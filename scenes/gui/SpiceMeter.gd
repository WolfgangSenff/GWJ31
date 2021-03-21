extends TextureProgress

onready var label = $Label
onready var timer = $Timer

var is_tinted = false

func _ready() -> void:
    label.text = "0%"
    connect("value_changed", self, "on_value_changed")
    timer.connect("timeout", self, "on_timer_timeout")
    
func _on_value_changed(value) -> void:
    label.text = str(value) + "%"
    if value == max_value:
        Globals.emit_signal("exit_open")
        timer.start()
        
func on_timer_timeout() -> void:
    is_tinted = !is_tinted
    if is_tinted:
        tint_under = Color.blue
    else:
        tint_under = Color.white
