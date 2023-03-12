extends Node

# The InputManager works with the BeatmapManager to
# read inputs and send key condition signals.

signal letter_hit(line: Line, letter: String, i: int, sd: int)
signal letter_miss(line: Line, letter: String)
signal letter_typo(letter: String)

@onready var beatmap_manager = $".."

# Window Management

var window_list: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	beatmap_manager.open_window.connect(on_window_open)
	beatmap_manager.close_window.connect(on_window_close)

### Event Hooks ###

func _input(event):
	if event is InputEventKey:
		# Don't listen to echo or unpress events.
		if event.echo or not event.pressed:
			return
		
		# Get the string. Make sure it's only one character.
		var input: String = event.as_text_keycode().to_lower()
		if input.length() != 1:
			return
		var inputs: Array[String] = [input, input.to_upper()]
		
		# Find a window that has this input.
		var check_list = window_list.duplicate()
		var hit: bool = false
		for index in range(check_list.size()):
			var window = check_list[index]
			if window[1] in inputs:
				# Remove the window from the list.
				window_list.pop_at(index)
				
				# Mark as a hit.
				letter_hit.emit(window[0], window[1], window[2], window[3])
				hit = true
		
		# If none hit, mark as a typo.
		if not hit:
			letter_typo.emit(input)

func on_window_open(line: Line, letter: String, i: int, sd: int):
	# Add a window for this.
	window_list.append([line, letter, i, sd])

func on_window_close(line: Line, letter: String, i: int, sd: int):
	# Look for the first window of this that matches.
	var check_list = window_list.duplicate()
	for index in range(check_list.size()):
		var window = check_list[index]
		if window == [line, letter, i, sd]:
			# Remove the window from the list.
			window_list.pop_at(index)
			
			# Mark as a miss.
			letter_miss.emit(line, letter)