extends CanvasLayer
class_name BeatmapManager

# The master Beatmap manager script.

var beatmap : Beatmap
var audio_stream: AudioStream
@onready var music = $Music

# Beatmap state
var current_sd: int = 0


func _init():
	var bl = BeatmapLoader.new()
	beatmap = bl.test_beatmap()
	audio_stream = beatmap.get_audio_stream()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set events.
	music.finished.connect(music_finish)
	
	# Start the track.
	music.set_stream(audio_stream)
	music.play()


func _process(delta):
	# Call music_process if the track is playing.
	if music.is_playing():
		# Get variables for the current state of the song.
		var t: float = music.get_playback_position()
		var sd: int = beatmap.get_subdivision(t)
		
		# Run music process.
		music_process(t)
		
		# Process all subdivisions.
		for process_sd in range(current_sd, sd + 1):
			var spawn: int = beatmap.get_spawned_subdivisions(process_sd)
			subdivision_process(process_sd, spawn)
		current_sd = sd + 1

### Music Logic ###

func music_process(t: float):
	pass
	
func subdivision_process(sd: int, spawn: int):
	print('sd: ', sd, ' / ', spawn)
	
	# Perform all actions.
	for action in beatmap.get_actions(sd):
		match action.get_type():
			Action.Type.SPAWN_KEY:
				action_spawn_key(action.get_args()[0])
			Action.Type.PRESS_KEY:
				action_press_key(action.get_args()[0])
			Action.Type.START_LINE:
				action_start_line(action.get_args()[0])
			Action.Type.END_LINE:
				aciton_end_line(action.get_args()[0])

func music_finish():
	print('Done!')

### Action Manager ###

func action_spawn_key(key: String):
	pass
	# print('Spawn: ', key)

func action_press_key(key: String):
	print('Press: ', key)

func action_start_line(line: Line):
	print('Start Line: ', line.get_lyric())

func aciton_end_line(line: Line):
	print('End Line: ', line.get_lyric())
