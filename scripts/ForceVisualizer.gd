extends Node2D


var force := Vector2.ZERO
export var scaler := 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	if force.length() < 0.2:
		return

	var end := force * scaler
	draw_line(Vector2.ZERO, end, Color.firebrick, 2)
	draw_circle(end, 4, Color.firebrick)

func set_force(f):
	force = f
	update()

