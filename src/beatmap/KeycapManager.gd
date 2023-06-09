extends Control

# The KeycapManager handles the actual spawning
# and cleanup of the visual scrolling keycaps.

@onready var beatmap_manager = $"../.."
@onready var input_manager = %InputManager
@onready var hitline = $Assets/HitlineFrame/Meter
@onready var assets = $Assets

@onready var scroll_note_tscn = preload("res://src/beatmap/scroll_note.tscn")

# Keep up with any active scroll notes.
var sd_to_scrollnote: Dictionary = {}


func _ready():
	beatmap_manager.spawn_key.connect(spawn_key)
	beatmap_manager.spawn_lion.connect(spawn_lion)
	input_manager.letter_hit.connect(on_key_press)


func _process(delta):
	# Figure out how large we can make the meter.
	var xmax_ratio = 1.0 / 780.0
	var ymax_ratio = 1.0 / 480.0
	var win_size: Vector2i = DisplayServer.window_get_size()
	var best_scale = min(xmax_ratio * win_size[0], ymax_ratio * win_size[1])
	#best_scale = round(best_scale * 4.0) / 4.0
	assets.set_scale(Vector2(best_scale, best_scale))


func spawn_key(line: Line, letter: String, sd: int) -> void:
	# When asked to spawn a key, look to spawning
	# a ScrollNote upon the Hitline.
	var scroll_note: ScrollNote = null
	if sd in sd_to_scrollnote:
		# Use an existing scroll note.
		scroll_note = sd_to_scrollnote[sd]
	else:
		# Create a new scrollnote.
		scroll_note = scroll_note_tscn.instantiate()
		hitline.add_child(scroll_note)
		scroll_note.startup(beatmap_manager, sd)
		sd_to_scrollnote[sd] = scroll_note
	
	# Add a letter to the scroll note.
	scroll_note.add_letter(letter)


func on_key_press(line: Line, letter: String, i: int, sd: int) -> void:
	# Find the scroll note and remove a letter from it.
	var scroll_note: ScrollNote = sd_to_scrollnote.get(sd)
	if scroll_note == null:
		return
	
	scroll_note.remove_letter(letter)
	if scroll_note.cleaned_up():
		sd_to_scrollnote.erase(sd)


func spawn_lion(sd: int):
	# Spawns a lion
	var scroll_note = scroll_note_tscn.instantiate()
	hitline.add_child(scroll_note)
	scroll_note.startup(beatmap_manager, sd, true)
