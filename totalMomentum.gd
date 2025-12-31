extends Label

onready var visualizer = $MomentumVisualizer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var momentum = 0
func _process(delta):
	momentum = Vector2.ZERO
	text = ""
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
		visualizer.add_vector(body.v * body.relative_mass, momentum, vectorColor)
		momentum += body.v * body.relative_mass
		text+= bodyName + "γ * Mass: " + str("%.2f" % body.relative_mass) +" Vel: "+ str("%.1f px/s" % body.v.length()) + "\n"	
	text+= "Total momentum: " + str("%.2fk" % (momentum.length()*0.001)) + "    ("+ str("%.2fk" % (momentum.x * 0.001)) + ", " +str("%.2fk" % (momentum.y * 0.001)) + ")" 
	
