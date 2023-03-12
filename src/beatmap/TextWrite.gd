extends RichTextLabel

@export var write_color: Color = Color.from_hsv(0, 0, 0)

func set_line(typed_line: String):
	# Set the text.
	set_text("[color=#" + write_color.to_html() + "]" + typed_line + "[/color]")
