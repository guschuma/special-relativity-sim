extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta;
	bbcode_text = "[center] %.2f s [/center]"%time
