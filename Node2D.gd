extends Node2D

onready var vp_a = $ViewportA
onready var vp_b = $ViewportB
onready var rect_a = $ViewportA/ColorRect
onready var rect_b = $ViewportB/ColorRect
onready var display = $DisplayRect
onready var wall_viewport = $ViewportWallMask

var flip = true

func _ready():
	var size = vp_a.size
	rect_a.material.set_shader_param("texel_size", Vector2(1.0/size.x, 1.0/size.y))
	rect_b.material.set_shader_param("texel_size", Vector2(1.0/size.x, 1.0/size.y))
	rect_a.material.set_shader_param("wall_tex", wall_viewport.get_texture())
	rect_b.material.set_shader_param("wall_tex", wall_viewport.get_texture())

func _process(delta):
	var body_pos_vp = get_body_pos_in_viewport(get_node("KinematicBody2D2"))
	rect_a.material.set_shader_param("body_pos0", body_pos_vp)
	rect_b.material.set_shader_param("body_pos0", body_pos_vp)
	body_pos_vp = get_body_pos_in_viewport(get_node("KinematicBody2D3"))
	rect_a.material.set_shader_param("body_pos1", body_pos_vp)
	rect_b.material.set_shader_param("body_pos1", body_pos_vp)

	if flip:
		rect_a.material.set_shader_param("prev_tex", vp_b.get_texture())
		rect_a.material.set_shader_param("body_pos0", body_pos_vp)
		display.material.set_shader_param("wave_tex", vp_a.get_texture())
	else:
		rect_b.material.set_shader_param("prev_tex", vp_a.get_texture())
		rect_b.material.set_shader_param("body_pos1", body_pos_vp)
		display.material.set_shader_param("wave_tex", vp_b.get_texture())

	flip = !flip

func get_body_pos_in_viewport(body):
	var screen_pos = body.get_viewport().get_canvas_transform().xform(body.global_position)

	var window_size = get_viewport_rect().size
	var vp_size = vp_a.size

	return screen_pos * (vp_size / window_size)
