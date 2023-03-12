extends RichTextLabel

@onready var line_node = $".."
@onready var animation_player = $"AnimationPlayer"
@export var line_color: Color = Color.from_hsv(0, 0, 0)

func _ready():
	line_node.line_update.connect(kick)

func set_line(typed_line: String):
	# Calculate the number of spaces needed.
	var spaces = ""
	for index in range(typed_line.length()):
		spaces += " "
		
	# Set the text.
	set_text(spaces + "[color=#" + line_color.to_html() + "]" + "[u] [/u][/color]")
	
	# Bounce animation.
	# animation_player.play("UnderlineKick")

func clear_line():
	set_text("")

func kick():
	animation_player.stop()
	animation_player.play("Kick")
