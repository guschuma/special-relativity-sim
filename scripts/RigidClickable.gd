extends RigidBody2D

export var strength = 2

onready var visualizer = $ForceVisualizer
var dragging = false

var relative_mass = 1
var c = 1000
var p := Vector2.ZERO

var gamma = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	custom_integrator = true

func _integrate_forces(state):
	var v = state.linear_velocity
	
	p = state.linear_velocity
	state.linear_velocity = p/(sqrt(mass*mass + p.length_squared()/(c * c)))

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		dragging = event.pressed

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if not event.pressed:
			dragging = false
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	gamma = 1.0 / sqrt(1.0 - linear_velocity.length_squared() / (c * c))
	relative_mass = mass*gamma
	if not dragging:
		visualizer.set_force(Vector2.ZERO)
		visualizer.visible = false
		return

	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position
	
	var impulse = direction * strength * delta
	apply_central_impulse(impulse)
	visualizer.set_force(impulse)
	visualizer.visible = true
