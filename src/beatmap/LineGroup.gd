extends VBoxContainer
class_name LineGroup

# The LineGroup is responsible for the creation
# and management of their LineNodes.

var line_node_tscn: PackedScene = preload("res://src/beatmap/line_node.tscn")
var linesToNode: Dictionary = {}
var active_lines: Array[Line] = []


func action_start_line(line: Line):
	# Create new line group.
	var line_node = line_node_tscn.instantiate()
	add_child(line_node)
	line_node.start(line)
	
	# Add this to our personal dict.
	linesToNode[line] = line_node
	active_lines.append(line)

func action_end_line(line: Line):
	# Get the line node.
	var line_node = linesToNode.get(line)
	line_node.end()
	active_lines.erase(line)
	
func action_correct_input(line: Line, key: String):
	var line_node = linesToNode.get(line)
	line_node.on_correct_input(key)
	
func action_ignored_input(line: Line, key: String):
	var line_node = linesToNode.get(line)
	line_node.on_ignored_input(key)

func action_whiffed_input(key: String):
	if active_lines == []:
		return
	var line = active_lines[0]
	var line_node = linesToNode.get(line)
	line_node.on_whiffed_input(key)
