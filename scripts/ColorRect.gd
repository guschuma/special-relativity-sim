extends ColorRect

onready var body0 = get_node("/root/Node2D/Node/KinematicBody2D2")
onready var observer = get_node("../Observer")

func _process(delta):
	material.set_shader_param("body_count", 1)
	material.set_shader_param("body_pos0", body0.global_position)
	material.set_shader_param("body_vel0", body0.v)
	material.set_shader_param("screen_size", rect_size)
	material.set_shader_param("body_count", 1)
	material.set_shader_param("rect_pos", rect_global_position)
	material.set_shader_param("obs_pos", observer.position)
	material.set_shader_param("obs_direction", observer.direction)
	material.set_shader_param("c", Global.c)
	
