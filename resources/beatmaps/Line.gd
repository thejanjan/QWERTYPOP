extends RefCounted
class_name Line

# A resource for a lyric line in a beatmap.
# Includes the time, text, which keys are pressed, and timings.

var line_sd: int
var lyric: String
var inputs: String
var timings: Array[int]
var start_delay: int
var end_delay: int

func _init(_line_sd: int = 0,
			_lyric: String = '', _inputs: String = '', _timings: Array[int] = [],
			_start_delay: int = -12, _end_delay: int = 12):
	line_sd = _line_sd
	lyric = _lyric
	inputs = _inputs
	timings = _timings
	start_delay = _start_delay
	end_delay = _end_delay
	
	# Validate just in case.
	var valid = validate()
	if valid != LineState.VALID:
		push_error('bad line state: ', valid)

### Simple Getters ###

func get_lyric() -> String:
	return lyric
	
func get_inputs() -> String:
	return inputs

### Getters ###

func get_actions(sd: int, bm: Beatmap) -> Array[Action]:
	# Get all actions at this instant.
	var actions: Array[Action] = []
	
	# Check out the endpoint delays.
	var start_sd = line_sd + start_delay
	var end_sd = line_sd + end_delay + timings[-1]
	if (sd == start_sd):
		actions.append(Action.new(Action.Type.START_LINE, [self]))
	if (sd == end_sd):
		actions.append(Action.new(Action.Type.END_LINE, [self]))
		
	# If this line is active, check for inputs.
	var scroll_speed = bm.get_scroll_speed()
	var timing_window = bm.get_timing_window()
	if (((start_sd - scroll_speed) <= sd) and (sd <= end_sd)):
		for i in range(timings.size()):
			# Get the variables at this timing.
			var letter = inputs[i]
			var timing = timings[i] + line_sd
			
			# Add actions if they match.
			if (sd == (timing - scroll_speed)):
				actions.append(Action.new(Action.Type.SPAWN_KEY, [self, letter, timing]))
			if (sd == timing):
				actions.append(Action.new(Action.Type.PRESS_KEY, [self, letter]))
			if (sd == (timing - timing_window)):
				actions.append(Action.new(Action.Type.OPEN_WINDOW, [self, letter, i, timing]))
			if (sd == (timing + timing_window)):
				actions.append(Action.new(Action.Type.CLOSE_WINDOW, [self, letter, i, timing]))
	
	# Return our actions.
	return actions

### Validation ###

enum LineState {VALID,
	INPUT_MUST_BEGIN_LYRIC, LETTERS_NOT_IN_LYRIC, INPUTS_OUT_OF_ORDER,
	TOO_MANY_TIMINGS, TOO_LITTLE_TIMINGS, TIMINGS_NOT_CONSECUTIVE}

func validate() -> LineState:
	# Validates if a resource is configured properly.
	# First, make sure the lyric starts with the right input.
	if lyric[0] != inputs[0]:
		return LineState.INPUT_MUST_BEGIN_LYRIC
		
	# Make sure all of the input letters are in the lyric.
	for letter in inputs:
		if letter not in lyric:
			return LineState.INPUTS_OUT_OF_ORDER
	
	# Make sure all of the input letters are in order.
	var current_inputs = String(inputs)
	for letter in lyric:
		if current_inputs != "" and letter == current_inputs[0]:
			current_inputs = current_inputs.right(-1)
	
	if current_inputs != "":
		return LineState.INPUTS_OUT_OF_ORDER
		
	# Ensure our timings are consecutive.
	var prevTiming: int = -1
	for timing in timings:
		if timing < prevTiming:
			return LineState.TIMINGS_NOT_CONSECUTIVE
		prevTiming = timing
	
	# Ensure we have the right amount of timings.
	if timings.size() < inputs.length():
		return LineState.TOO_LITTLE_TIMINGS
	if timings.size() > inputs.length():
		return LineState.TOO_MANY_TIMINGS
	
	# Everything is good!
	return LineState.VALID
