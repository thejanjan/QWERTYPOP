extends AudioStreamPlayer

@onready var input_manager = %InputManager


func _ready():
	input_manager.final_letter_hit.connect(func(line: Line, letter: String): play())
