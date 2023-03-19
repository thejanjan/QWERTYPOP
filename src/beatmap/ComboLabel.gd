extends RichTextLabel

@onready var input_manager = %InputManager

var top: int = 0
var bottom: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	input_manager.letter_hit.connect(letter_hit)
	input_manager.letter_miss.connect(letter_miss)
	input_manager.letter_typo.connect(letter_typo)
	update()

func letter_hit(line: Line, letter: String, i: int, sd: int):
	top += 1
	bottom += 1
	update()

func letter_miss(line: Line, letter: String):
	bottom += 1
	update()

func letter_typo(letter: String):
	bottom += 1
	update()

func update():
	set_text("[center]%s/%s" % [top, bottom])
