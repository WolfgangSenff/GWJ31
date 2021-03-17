extends Area2D

export (float) var LifeTime
export (float) var Damage
export (float) var TopSpeed
export (float) var Acceleration

var _current_lifetime = 0
var _current_speed = 0

onready var _explosion_particles = $CPUParticles2D
onready var _sprite = $Sprite
onready var _trail = $Trail

func _ready() -> void:
	set_physics_process(false)
	connect("area_entered", self, "_on_area_entered", [], CONNECT_ONESHOT)
	

func _physics_process(delta : float) -> void:
	_current_lifetime += delta
	if _current_lifetime > LifeTime:
		explode()
		set_physics_process(false)
	
	_current_speed += Acceleration * delta
	_current_speed = clamp(_current_speed, 0, TopSpeed)
	global_position += _current_speed * Vector2.RIGHT.rotated(global_rotation - deg2rad(90))

func _on_area_entered(area) -> void:
	if area.is_in_group("weapon"):
		set_physics_process(false)
		explode()

func explode() -> void:
	_sprite.hide()
	_trail.hide()
	_explosion_particles.emitting = true
	yield(get_tree().create_timer(5), "timeout")
	queue_free()
