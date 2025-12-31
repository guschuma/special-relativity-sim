extends Node2D

var vectors := []  # list of {vector, start} dictionaries
export var scaler := 80
export (Font) var font
var delta = 0
func _draw():
	#draw_arc(center, radius, 0, TAU, points, color)
	var oneOverC = 1/Global.c
	draw_arc(Vector2.ZERO, scaler, 0, -TAU*0.25, 25, Color.lightslategray)
	draw_line(Vector2(-10,0), Vector2(110,0), Color.lightslategray, 1)
	
	draw_string(font, Vector2(50,12), "Velocity[px/s]", Color.lightslategray)
	
	draw_string(font, Vector2(5,-110), "c × ∆τ/∆t  [px/s]", Color.lightslategray)
	draw_circle(Vector2(110,0), 3, Color.lightslategray)
	draw_line(Vector2(0,10), Vector2(0,-110), Color.lightslategray, 1)
	draw_circle(Vector2(0,-110), 3, Color.lightslategray)
	
	for item in vectors:
		var velocity = item.velocity
		var oneOverGamma = sqrt(1 - (velocity*velocity)/(Global.c*Global.c))
		var end = Vector2(item.velocity, -Global.c*oneOverGamma)
		var vectorDrawing = end*oneOverC*scaler;
		if((end).length() > 1):
			draw_line(Vector2.ZERO, vectorDrawing, item.color, 2)
			draw_circle(end*oneOverC*scaler, 3, item.color)
			draw_line(Vector2.ZERO, Vector2(vectorDrawing.x, 0), item.color, 1)
			draw_line(Vector2(vectorDrawing.x, 0), vectorDrawing, item.color, 1)
			
			var offset = Vector2(vectorDrawing.y, -vectorDrawing.x).normalized()*scaler*0.2
			draw_string(font, ((vectorDrawing + Vector2.ZERO)*0.5 + offset), "c", item.color)
			
			if(item.color == Color.crimson): offset = Vector2(-2,1)*scaler*0.2 # first body
			else: offset = Vector2(-1,1)*scaler*0.4
			draw_string(font, ((Vector2(vectorDrawing.x,0))*0.5 + offset), "%.2f" % velocity, item.color)
			
			offset = Vector2(1,0)*scaler*0.1
			draw_string(font, ((Vector2(vectorDrawing.x,0) + vectorDrawing)*0.5 + offset), "%.2fc" % oneOverGamma, item.color)

func add_vector(v, vector_color):
	vectors.append({ "velocity": v.length(), "color": vector_color })
	update()

func reset_vectors():
	vectors.clear()
	update()
