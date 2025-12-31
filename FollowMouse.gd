extends KinematicBody2D

var direction = Vector2.ZERO
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	direction = mouse_pos - global_position
	direction = direction.normalized()
	rotation = direction.angle()
