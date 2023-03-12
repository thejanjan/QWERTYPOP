extends RichTextLabel

@export var type_color: Color = Color.from_hsv(0, 0, 0.5)

func set_line(line: Line, typed_input: String, whiff_count: int = 0):
	# Sets the TextType to match a text.
	var lyric: String = line.get_lyric()
	var input: String = line.get_inputs()
	var str: String = ""
	
	# Cover the typed input first.
	for index in range(typed_input.length()):
		# Get the letter, and add it to the string.
		var letter = typed_input[index]
		str += letter
		
		# Only attempt to remove letters if we haven't whiffed any more.
		if whiff_count > 0:
			whiff_count -= 1
			continue
		
		# Remove this letter from the lyric/input if present.
		if lyric == "":
			continue
		
		var lyric_letter = lyric[0]
		lyric = lyric.right(-1)
		
		if input == "":
			continue
		
		if lyric_letter == input[0]:
			input = input.right(-1)
	
	# Determine the string.
	for index in range(lyric.length()):
		# Get the letter.
		var letter = lyric[index]
		
		# If there is still input to cover, add it.
		if input != "" and letter == input[0]:
			input = input.right(-1)
			str += letter
		else:
			str += " "
	
	# Set the text.
	set_text("[color=#" + type_color.to_html() + "]" + str + "[/color]")
	
