extends Node2D

var colors = [Color(0.0, 0.0, 0.2), Color(0.0, 0.0, 1.0)]

onready var room = get_parent()

func _draw():
	var angle = -22.5
	if room.power == true:
		for i in self.get_children():
			draw_circle_arc(Vector2(0, 0), 70, angle, angle + 45, colors[int(i.get_child(0).lit)])
			angle += 45

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
		
func _process(delta):
	update()
