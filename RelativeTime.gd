extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time = 0.0

func _ready():
	bbcode_enabled = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var c = Global.c;
	time += delta * sqrt(1 - get_parent().v.length_squared()/(c * c));

	bbcode_text = "[center] %.2fs [/center]" % time
