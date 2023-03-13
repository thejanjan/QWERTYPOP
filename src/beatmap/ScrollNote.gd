extends Control
class_name ScrollNote

@onready var rich_text_label = $Assets/Keycap/RichTextLabel
@onready var assets = $Assets
@onready var keycap = $Assets/Keycap
@onready var line = $Assets/Line


@onready var rhythm = $Assets/Keycap/Rhythm

var px = "[center][color=#000000]"
var sx = "[/color][/center]"

var _mgr: BeatmapManager = null
var start_time: float = 0.0
var scroll_mult: float = 1.0

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


func startup(mgr: BeatmapManager, sd: int, as_line: bool = false) -> void:
	# Starts up the ScrollNote.
	# Figures out what speed it needs to be at.
	_mgr = mgr
	var beatmap = mgr.get_beatmap()
	var bpm = beatmap.get_bpm()
	var map_sd = beatmap.get_map_SD()
	var scroll_spd = beatmap.get_scroll_speed()
	
	# Get the SDs per second.
	var sds_per_sec = float((bpm / 60.0) * map_sd)
	scroll_mult = float(scroll_spd) / sds_per_sec
	start_time = ((sd) / sds_per_sec) - (scroll_mult)
	var test_time = mgr.get_t()
	
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


func _process(delta):
	# Seek to the right time.
	if _mgr == null:
		return
	var real_time = _mgr.get_t()
	var t = (real_time - start_time) / scroll_mult
	place_assets(t)


func add_letter(letter: String) -> void:
	current_letters += letter
	rich_text_label.set_text(px + get_render_letters() + sx)


func remove_letter(letter: String) -> void:
	var index = current_letters.find(letter)
	if index == -1:
		return
	if len(current_letters) == 1:
		current_letters = ""
		queue_free()
		return
	current_letters = current_letters.left(index) + current_letters.right(index - current_letters.length() + 1)
	rich_text_label.set_text(px + get_render_letters() + sx)


func cleaned_up():
	return current_letters == ""


func get_render_letters() -> String:
	return current_letters


func place_assets(t: float):
	if not assets:
		return
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
	
	var text_ratio = 55.0 / 648.0
	var text_size = text_ratio * winsize.y
	rich_text_label.add_theme_font_size_override("normal_font_size", text_size)
	
	if t > 1.3:
		queue_free()


func on_anim_finish():
	queue_free()
