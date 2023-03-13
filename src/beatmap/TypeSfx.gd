extends AudioStreamPlayer

@onready var input_manager = %InputManager

var type_sfx: Array = [
	preload("res://resources/sfx/typing/type-01.ogg"),
	preload("res://resources/sfx/typing/type-02.ogg"),
	preload("res://resources/sfx/typing/type-03.ogg"),
	preload("res://resources/sfx/typing/type-04.ogg"),
	preload("res://resources/sfx/typing/type-05.ogg"),
	preload("res://resources/sfx/typing/type-06.ogg"),
	preload("res://resources/sfx/typing/type-07.ogg"),
	preload("res://resources/sfx/typing/type-08.ogg"),
	preload("res://resources/sfx/typing/type-09.ogg"),
]


func _ready():
	# Load in the audio.
	var audio_stream: AudioStreamRandomizer = get_stream()
	for audio in type_sfx:
		audio_stream.add_stream(-1, audio)
	
	# Attach to input mgr.
	input_manager.letter_hit.connect(click)
	input_manager.letter_typo.connect(whiff)


func click(line: Line, letter: String, i: int, sd: int):
	play()


func whiff(letter: String):
	pass
