extends Camera2D

const ZoomAmount = Vector2(6, 6)
const ZoomSpeed = .3

onready var tween = $Tween
onready var zoom_in_position = $ZoomInPosition
onready var zoom_out_position = $ZoomOutPosition

func zoom_out(for_time) -> void:
    var current_pos = zoom_in_position.global_position
    tween.interpolate_property(self, "zoom", zoom, zoom + ZoomAmount, ZoomSpeed, Tween.TRANS_LINEAR, Tween.EASE_IN)
    tween.start()
    yield(get_tree().create_timer(for_time), "timeout")
    tween.interpolate_property(self, "zoom", zoom, zoom - ZoomAmount, ZoomSpeed, Tween.TRANS_LINEAR, Tween.EASE_IN)
    tween.start()
