extends Node2D

var colors = {
    "cooled" : [Color(0.0, 0.0, 0.2), Color(0.0, 0.0, 1.0)],
    "hot" : [Color(0.2, 0.2, 0.0), Color(1.0, 1.0, 0.0)],
    "overcharge" : [Color(0.2, 0.0, 0.0), Color(1.0, 0.0, 0.0)],
}

onready var room = get_parent()

func _draw():
    var angle = -22.5
    if room.power == true:
        for i in self.get_children():
            draw_circle_arc(Vector2(0, 0), 70, angle, angle + 45, colors[i.get_child(0).state][int(i.get_child(0).lit)])
            angle += 45

func draw_circle_arc(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = PoolVector2Array()

    for i in range(nb_points + 1):
        var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
    draw_polyline(points_arc, color, 5.0)
        
func _process(delta):
    update()
