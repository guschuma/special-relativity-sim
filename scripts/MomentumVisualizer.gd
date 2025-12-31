extends Node2D

var vectors := []  # list of {vector, start} dictionaries
export var scaler := 0.01
export (Font) var font
func _draw():
	#draw_arc(center, radius, 0, TAU, points, color)
	var oneOverC = 1/Global.c
	draw_arc(Vector2.ZERO, 10, 0, TAU, 100, Color.antiquewhite)
	draw_arc(Vector2.ZERO, 5, 0, TAU, 100, Color.antiquewhite)
	for item in vectors:
		var start = item.start * scaler
		var end = (item.start + item.vector) * scaler
		if((end - start).length() > 1):
			draw_line(start*0.01, end*0.01, item.color, 1)
			draw_circle(end*0.01, 3, item.color)
			
			if font:
				var mag_text = str("%.2fk" % (item.vector.length()*0.001))
				var offset = Vector2(item.vector.y, -item.vector.x).normalized()*40.0
				draw_string(font, ((end + start)*0.5 + offset)*0.01, mag_text, item.color)


func add_vector(v, start_pos, vector_color):
	vectors.append({ "vector": v, "start": start_pos, "color": vector_color })
	update()

func reset_vectors():
	vectors.clear()
	update()
