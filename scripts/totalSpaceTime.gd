extends Label

onready var visualizer = $SpaceTimeVisualizer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var momentum = 0
func _process(delta):
	momentum = Vector2.ZERO

	visualizer.reset_vectors()
	for body in get_tree().get_nodes_in_group("movably"):
		var vectorColor = Color.black
		var bodyName = ""
		if(body.name == "KinematicBody2D2"):
			bodyName = "1: "
			vectorColor = Color.crimson
		if(body.name == "KinematicBody2D3"):
			bodyName = "2: "
			vectorColor = Color.darkturquoise
		visualizer.add_vector(body.v, vectorColor)
		momentum += body.v * body.relative_mass
