extends "res://src/beatmap/ComboLabel.gd"

var true_ratio: float = 100.0
var render_ratio: float = 100.0

func update():
	if bottom != 0:
		true_ratio = (float(top) / float(bottom)) * 100.0
	else:
		true_ratio = 100.0
	

func _process(delta):
	render_ratio = lerp(render_ratio, true_ratio, 0.05)
	set_text(("[center]" + ("%0.2f" % render_ratio) + "%"))
