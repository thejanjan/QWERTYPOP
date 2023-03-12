extends Control

# The KeycapManager handles the actual spawning
# and cleanup of the visual scrolling keycaps.

@onready var beatmap_manager = $"../../.."
@onready var input_manager = %InputManager
@onready var hitline = $Hitline

@onready var scroll_note_tscn = preload("res://src/beatmap/scroll_note.tscn")

# Keep up with any active scroll notes.
var sd_to_scrollnote: Dictionary = {}


func _ready():
	beatmap_manager.spawn_key.connect(spawn_key)
	beatmap_manager.spawn_lion.connect(spawn_lion)
	input_manager.letter_hit.connect(on_key_press)


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
		scroll_note.startup(beatmap_manager.get_beatmap(), sd)
		sd_to_scrollnote[sd] = scroll_note
	
	# Add a letter to the scroll note.
	scroll_note.add_letter(letter)


func on_key_press(line: Line, letter: String, i: int, sd: int) -> void:
	# Find the scroll note and remove a letter from it.
	var scroll_note: ScrollNote = sd_to_scrollnote.get(sd)
	if scroll_note != null:
		return
	
	scroll_note.remove_letter(letter)


func spawn_lion():
	# Spawns a lion
	var scroll_note = scroll_note_tscn.instantiate()
	hitline.add_child(scroll_note)
	scroll_note.startup(beatmap_manager.get_beatmap(), 0, true)
