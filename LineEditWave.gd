extends LineEdit

export (NodePath) var color_rect_path
onready var color_rect := get_node(color_rect_path) as ColorRect
export (NodePath) var color_rect_path2
onready var color_rect2 := get_node(color_rect_path2) as ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("text_entered", self, "_on_text_entered")

func _on_text_entered(text):
	var mat := color_rect.material
	mat.set_shader_param("wave_velocity", text.to_float())
	var mat2 := color_rect2.material
	mat2.set_shader_param("wave_velocity", text.to_float())
	print(text.to_float())

