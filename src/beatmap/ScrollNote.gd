extends Control
class_name ScrollNote

@onready var rich_text_label = $Assets/Keycap/RichTextLabel
@onready var animation_player = $AnimationPlayer
@onready var assets = $Assets
@onready var keycap = $Assets/Keycap
@onready var line = $Assets/Line


@onready var rhythm = $Assets/Keycap/Rhythm

var px = "[center][color=#000000]"
var sx = "[/color][/center]"

var _offset: float = 0.0
@export var offset: float:
	get:
		return _offset
	set(val):
		_offset = val
		place_assets()


var current_letters: String = ""
var rhythm_cols: Dictionary = {
	# Whole Notes
	(0.0 / 1.0): Color.WHITE,
	(1.0 / 4.0): Color.DARK_ORANGE,
	(2.0 / 4.0): Color.AQUA,
	(3.0 / 4.0): Color.DARK_ORANGE,
	
	# Triplets
	(1.0 / 3.0): Color.BLUE_VIOLET,
	(2.0 / 3.0): Color.BLUE_VIOLET,
	
	# Sextuplets
	(1.0 / 6.0): Color.DARK_MAGENTA,
	(5.0 / 6.0): Color.DARK_MAGENTA,
}

func _init():
	hide()


func startup(beatmap: Beatmap, sd: int, as_line: bool = false) -> void:
	# Starts up the ScrollNote.
	# Figures out what speed it needs to be at.
	var bpm = beatmap.get_bpm()
	var map_sd = beatmap.get_map_SD()
	var scroll_spd = beatmap.get_scroll_speed()
	
	# Get the SDs per second.
	var sds_per_sec = float((bpm / 60.0) * map_sd)
	var scroll_mult = float(scroll_spd) / sds_per_sec
	animation_player.play("Slide", -1, 1.0 / scroll_mult)
	animation_player.animation_finished.connect(on_anim_finish)
	
	if as_line:
		keycap.hide()
		line.show()
	else:
		# What should the rhythm coloring be?
		keycap.show()
		line.hide()
		
		var reduced_sd: int = sd % map_sd
		var beat_amount: float = float(reduced_sd) / float(map_sd)
		rhythm.set_color(rhythm_cols.get(beat_amount, Color.RED))


func add_letter(letter: String) -> void:
	current_letters += letter
	rich_text_label.set_text(px + current_letters + sx)


func remove_letter(letter: String) -> void:
	var index = current_letters.find(letter)
	if index == -1:
		return
	if len(current_letters) == 1:
		queue_free()
		return
	current_letters = current_letters.left(index) + current_letters.right(index - current_letters.length() + 1)
	rich_text_label.set_text(px + current_letters + sx)


func place_assets():
	if not assets:
		return
	var t = offset
	var winsize: Vector2i = DisplayServer.window_get_size()
	var xoffset: float = (1 - t) * (winsize.x)
	assets.set_position(Vector2(xoffset, 0))
	show()
	
	# also change note scaling
	var x_ratio = 45.0 / 110.0
	var y_ratio = 110.0 / 648.0
	var new_yscale = y_ratio * winsize.y
	var new_xscale = x_ratio * new_yscale
	set_custom_minimum_size(Vector2(new_xscale, new_yscale))
	
	if t > 1.3:
		queue_free()


func on_anim_finish():
	queue_free()
