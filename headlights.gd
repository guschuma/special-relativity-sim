extends Light2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var body_velocity = get_parent().v
	position = 20*body_velocity/Global.c
	energy = 0.05*body_velocity.length_squared()/(Global.c)*0.5
