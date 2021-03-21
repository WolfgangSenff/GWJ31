extends Area2D

const MaxLinearSpeed = 100
const MaxRotationalSpeed = 100

var starting_rotation

func _ready() -> void:
    starting_rotation = rotation

func _on_SpiceJar_area_entered(area: Area2D) -> void:
    Globals.emit_signal("spice_picked_up")
    queue_free()
    
func _physics_process(delta: float) -> void:
    rotation += deg2rad(MaxRotationalSpeed * delta)
    position += MaxLinearSpeed * delta * Vector2.RIGHT.rotated(starting_rotation)


func _on_Timer_timeout() -> void:
    queue_free()
