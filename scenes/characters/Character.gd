extends Area2D

onready var navigator = $Navigator2D
onready var sprite = $AnimatedSprite

export (String) var CharacterName

var _character_selected = false
var _last_direction = Vector2.UP

func _ready() -> void:
    navigator.connect("on_moved", self, "_on_character_moved")
    navigator.connect("on_destination_reached", self, "_on_destination_reached")
    _on_destination_reached(null, null)

func _on_destination_reached(nav, pos) -> void:
    if abs(_last_direction.y) >= abs(_last_direction.x):
        if _last_direction.y < 0:
            sprite.play("back_act")
        else:
            sprite.play("front_act")
    else:
        if _last_direction.x < 0:            
            sprite.play("side_act")
            sprite.scale.x = 1
        else:
            sprite.play("side_act")
            sprite.scale.x = -1

func _on_character_moved(direction) -> void:
    _last_direction = direction
    if abs(direction.y) >= abs(direction.x):
        if direction.y < 0:
            sprite.play("back_walk")
        else:
            sprite.play("front_walk")
    else:
        if direction.x < 0:            
            sprite.play("side_walk")
            sprite.scale.x = 1
        else:
            sprite.play("side_walk")
            sprite.scale.x = -1
        

func _on_Character_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    pass
    
func _unhandled_input(event):
    if event is InputEventMouseButton:
        if _character_selected:
            navigator.is_navigating = false
            yield(get_tree(), "idle_frame")
            navigator.navigate_to(get_global_mouse_position() - get_parent().global_position)
        else:
            character_activated()

func character_activated() -> void:
    pass
