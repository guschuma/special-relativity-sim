extends Node2D

var c: float = 100


export var max_range := 300.0
var active_body = null
var dragging = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		dragging = event.pressed
		if dragging:
			active_body = get_closest_body()
			if active_body != null:
				active_body.set_dragging(true)
		else:
			if active_body != null:
				active_body.set_dragging(false)
			active_body = null


func _physics_process(delta):
	if dragging and active_body:
		var mouse_pos = get_global_mouse_position()
		var dir = mouse_pos - active_body.global_position
		active_body.apply_external_force(dir * 5)


func get_closest_body():
	var mouse_pos = get_global_mouse_position()
	var best = null
	var best_d2 = max_range * max_range

	for b in get_tree().get_nodes_in_group("movably"):
		var d2 = b.global_position.distance_squared_to(mouse_pos)
		if d2 < best_d2:
			best_d2 = d2
			best = b
	return best
