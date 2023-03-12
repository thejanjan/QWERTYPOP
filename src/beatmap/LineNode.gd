extends Control

# A LineNode. Visually represents a Line.
# Takes in various actions & events to modify the Line.

signal line_update()

# Node state.
var line: Line
var input_state: String
var typed_line: String = ""
var whiffed_letters: Dictionary = {}

var _node_height: float = 1.0
@export var node_height: float:
	get:
		return _node_height
	set(val):
		_node_height = max(0.0, val)
		_update_visible_scale()

# Node onreadys.
@onready var text_write: RichTextLabel = $TextWrite
@onready var text_type: RichTextLabel = $TextType
@onready var text_line: RichTextLabel = $TextLine
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func start(_line: Line):
	# Set the line we're given.
	line = _line
	input_state = line.get_inputs()
	
	# Set visibility state.
	set_initial_state()
	
	# Scale in like a Boss.
	_node_height = 0
	hide()
	animation_player.play("TextSpawn", -1, 1.2)
	
func end():
	set_final_state()

# Animation Hooks

func _update_visible_scale() -> void:
	var minimum_y = 100
	set_custom_minimum_size(Vector2(10000, node_height * minimum_y))
	if node_height < 0.05:
		hide()
	else:
		show()

# Render State

func set_initial_state() -> void:
	# Sets the initial visibility state of the line.
	text_type.set_line(line, "")
	text_write.set_line("")
	text_line.set_line("")
	
func set_final_state() -> void:
	text_line.clear_line()

func on_correct_input(pressed_letter: String) -> void:
	# When a letter is hit correctly, call this.
	# Figure out the input to remove.
	var removed: bool = false
	for index in range(input_state.length()):
		var letter = input_state[index]
		if letter == pressed_letter:
			var left = input_state.left(index)
			var right = input_state.right(input_state.length() - index - 1)
			input_state = left + " " + right
			removed = true
			break
	
	if not removed:
		return
		
	# Update the typed line.
	update_typed_line()

func on_whiffed_input(pressed_letter: String) -> void:
	# When a letter is whiffed, call this.
	var whiffed_count: int = 0
	for string in whiffed_letters.values():
		whiffed_count += string.length()
	var whiffed_position: int = typed_line.length() - whiffed_count
	
	# Add the whiffed letter to this index.
	if whiffed_position not in whiffed_letters:
		whiffed_letters[whiffed_position] = ""
	whiffed_letters[whiffed_position] += pressed_letter
		
	# Update the typed line.
	update_typed_line()

func on_ignored_input(pressed_letter: String) -> void:
	# When a letter is ignored, call this.
	# Figure out the input to mark as missed.
	var removed: bool = false
	for index in range(input_state.length()):
		var letter = input_state[index]
		if letter == pressed_letter:
			var left = input_state.left(index)
			var right = input_state.right(input_state.length() - index - 1)
			input_state = left + "`" + right
			removed = true
			break
	
	if not removed:
		return
		
	# Update the typed line.
	update_typed_line()

func update_typed_line() -> void:
	# Updates the typed line to match current input state.
	typed_line = ""
	
	# Get local vars.
	var lyric = line.get_lyric()
	var inputs = line.get_inputs()
	var temp_state = input_state
	var last_missed = false
	
	# Go through each letter of the lyric and add it
	# into the typed line, assuming that we have
	# hit the input for it.
	for i in range(lyric.length()):
		# Get the current lyric.
		var l_lyric = lyric[i]
		
		# Get input vars.
		var l_input = inputs[0] if inputs else ""
		var l_istate = temp_state[0] if temp_state else ""
		
		# Does this input match up with the lyric?
		if inputs != "" and l_lyric == l_input:
			# Is the input ignored?
			if l_istate == "`":
				# Yikes, input was ignored.
				# Just kinda skip this one...
				inputs = inputs.right(-1)
				temp_state = temp_state.right(-1)
				typed_line += "|"
				last_missed = true
			# Is the input pressed?
			elif l_istate == " ":
				# The input is pressed.
				# Pop this input, add the lyric.
				inputs = inputs.right(-1)
				temp_state = temp_state.right(-1)
				typed_line += l_lyric
				last_missed = false
			else:
				# The input is not pressed.
				# Do not add this line, end now.
				break
		
		# The input does not match up with the lyric.
		# Therefore, it need not be pressed.
		# Add it to the typed line.
		else:
			if last_missed:
				# Oh, we missed the last note.
				# Do some funny.
				if l_lyric == " ":
					typed_line += l_lyric
				else:
					typed_line += "|"
			else:
				# Regular add yay!!
				typed_line += l_lyric
				
	# Set up the visible line.
	var visible_line = typed_line
				
	# Add whiffed letters to the typed line.
	var whiff_count = 0
	var whiff_indices: Array = whiffed_letters.keys()
	while whiff_indices:
		# Get the latest letter index.
		var index = whiff_indices.max()
		whiff_indices.erase(index)
		
		# Get the string present.
		var whiff_string: String = "[color=#FF0000][s]" + whiffed_letters[index] + "[/s][/color]"
		
		# Add it to the typed line.
		typed_line = typed_line.left(index) + whiffed_letters[index] + typed_line.right(typed_line.length() - index)
		visible_line = visible_line.left(index) + whiff_string + visible_line.right(visible_line.length() - index)
		
		# Increment whiff count.
		whiff_count += whiffed_letters[index].length()
		
	# Replace ? with red ?s.
	typed_line = typed_line.replace("|", "?")
	visible_line = visible_line.replace("|", "[color=#FF0000]?[/color]")
	
	# Update input states.
	text_type.set_line(line, typed_line, whiff_count)
	text_write.set_line(visible_line)
	text_line.set_line(typed_line)
	
	# Send signal.
	line_update.emit()
