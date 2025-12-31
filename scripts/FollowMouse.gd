extends KinematicBody2D

var direction = Vector2.ZERO

func _draw():
	draw_circle(Vector2.ZERO, 30, Color.gray)
	draw_circle(Vector2(30,0), 10, Color.gray)

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	direction = mouse_pos - global_position
	direction = direction.normalized()
	rotation = direction.angle()
	update()
