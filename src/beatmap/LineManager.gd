extends Control

# The LineManager manages the LineGroups by giving each
# Line (when procced to start or end) to the relevant LineGroup.

@onready var beatmap_manager = $"../../.."
@onready var line_group = $LineGroup
@onready var input_manager = %InputManager


func _ready():
	beatmap_manager.start_line.connect(action_start_line)
	beatmap_manager.end_line.connect(action_end_line)
	input_manager.letter_hit.connect(action_correct_input)
	input_manager.letter_miss.connect(action_ignored_input)
	input_manager.letter_typo.connect(action_whiffed_input)

func action_start_line(line: Line):
	# Pick a line group and defer the action to it.
	var group = get_line_group(line)
	group.action_start_line(line)

func action_end_line(line: Line):
	# Pick a line group and defer the action to it.
	var group = get_line_group(line)
	group.action_end_line(line)
	
func action_correct_input(line: Line, key: String, i: int, sd: int):
	var group = get_line_group(line)
	group.action_correct_input(line, key)
	
func action_ignored_input(line: Line, key: String):
	var group = get_line_group(line)
	group.action_ignored_input(line, key)
	
func action_whiffed_input(key: String):
	var group = line_group
	group.action_whiffed_input(key)

func get_line_group(line: Line) -> LineGroup:
	return line_group
