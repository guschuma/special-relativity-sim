extends KinematicBody2D

export var mass := 1.0
export var outlineColor := Color.black

var p := Vector2.ZERO   # relativistic momentum
var force := Vector2.ZERO
var v = Vector2.ZERO
var dragging := false


var relative_mass = 1
onready var visualizer = $ForceVisualizer

onready var observer = get_node("../../Observer")
var normalVelocity = 0
var vc = 0
func _draw():
	var doppler = sqrt((1+vc)/(1-vc))
	#currentColor = infrared.linear_interpolate(ultraviolet, value)
	var greenWave = 550* doppler
	var blueWave = 410 * doppler
	var greenColor = wavelength_to_rgb(greenWave)
	var blueColor = wavelength_to_rgb(blueWave)
	draw_circle(Vector2.ZERO, 20, (blueColor).darkened(0.0))
	draw_arc(Vector2.ZERO, 12, 0, TAU, 100, outlineColor)


func _ready():
	add_to_group("movably")
	
func get_momentum():
	return p

func set_momentum(new_p):
	p = new_p
	
func apply_external_force(f):
	force = f
	
func set_dragging(drag):
	dragging = drag

func _physics_process(delta):
	var c := Global.c 
	# reset force every frame

	if dragging:
		visualizer.visible = true
	else:
		force = Vector2.ZERO
		visualizer.visible = false
	visualizer.set_force(force)

	# --- RELATIVISTIC INTEGRATION ---

	# integrate momentum
	p += force * delta

	# recover velocity from momentum
	var p2 = p.length_squared()
	var denom = sqrt(mass * mass + p2 / (c * c))
	v = p / denom
	
	var gamma = 1/sqrt(1-v.length_squared()/(c * c))
	relative_mass = gamma*mass
	# integrate position

	
	var collision = move_and_collide(v * delta)
	
	normalVelocity = observer.direction.dot(v)
	vc = normalVelocity / Global.c
	
	if collision:
		var n = collision.normal.normalized()
		var other = collision.collider

		if other.has_method("get_momentum"):
			var p1 = p
			var pOther = other.get_momentum()

			var p1n = n * p1.dot(n)
			var p2n = n * pOther.dot(n)

			p = p - p1n + p2n
			other.set_momentum(pOther - p2n + p1n)
		else:
			# reflect momentum (elastic collision)
			p = p - 2.0 * p.dot(n) * n

	update()


func wavelength_to_rgb(wavelength_nm: float) -> Color:
	var r: float = 0.0
	var g: float = 0.0
	var b: float = 0.0
	var alpha: float = 1.0

	if wavelength_nm >= 380.0 and wavelength_nm <= 440.0:
		r = -(wavelength_nm - 440.0) / (440.0 - 380.0)
		b = 1.0
	elif wavelength_nm >= 440.0 and wavelength_nm <= 490.0:
		g = (wavelength_nm - 440.0) / (490.0 - 440.0)
		b = 1.0
	elif wavelength_nm >= 490.0 and wavelength_nm <= 510.0:
		g = 1.0
		b = -(wavelength_nm - 510.0) / (510.0 - 490.0)
	elif wavelength_nm >= 510.0 and wavelength_nm <= 580.0:
		r = (wavelength_nm - 510.0) / (580.0 - 510.0)
		g = 1.0
	elif wavelength_nm >= 580.0 and wavelength_nm <= 645.0:
		r = 1.0
		g = -(wavelength_nm - 645.0) / (645.0 - 580.0)
	elif wavelength_nm >= 645.0 and wavelength_nm <= 780.0:
		r = 1.0
	
	# Optional: adjust intensity near the ends of the spectrum
	var intensity: float = 1.0
	if wavelength_nm > 700.0:
		intensity = 0.3 + 0.7 * (780.0 - wavelength_nm) / (780.0 - 700.0)
	elif wavelength_nm < 420.0:
		intensity = 0.3 + 0.7 * (wavelength_nm - 380.0) / (420.0 - 380.0)

	r *= intensity
	g *= intensity
	b *= intensity

	# Ensure values are within Godot's 0.0 to 1.0 range
	r = clamp(r, 0.0, 1.0)
	g = clamp(g, 0.0, 1.0)
	b = clamp(b, 0.0, 1.0)

	return Color(r, g, b, alpha)
