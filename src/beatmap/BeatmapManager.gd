extends CanvasLayer
class_name BeatmapManager

# The master Beatmap manager script.
var beatmap: Beatmap
var audio_stream: AudioStream

@onready var music = $Music
@onready var line_manager = %LineManager
@onready var camera_3d = %Camera3D

# Beatmap state
var current_sd: int = 0

# Signal declarations
signal spawn_key(line: Line, key: String, sd: int)
signal press_key(line: Line, key: String, i: int, sd: int)
signal start_line(line: Line)
signal end_line(line: Line)
signal open_window(line: Line, key: String, i: int, sd: int)
signal close_window(line: Line, key: String, i: int, sd: int)
signal spawn_lion()

signal song_start(duration: float)
signal subdivision(sd: int)

# Action to signal mapping
var action2signal: Dictionary = {
	Action.Type.SPAWN_KEY: spawn_key,
	Action.Type.PRESS_KEY: press_key,
	Action.Type.START_LINE: start_line,
	Action.Type.END_LINE: end_line,
	Action.Type.OPEN_WINDOW: open_window,
	Action.Type.CLOSE_WINDOW: close_window,
	Action.Type.SPAWN_LION: spawn_lion,
}

# Inits/Step
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
	music.set_pitch_scale(beatmap.get_speed_mult())
	music.play()
	
	# Emit signals.
	var duration: float = audio_stream.get_length() / beatmap.get_speed_mult()
	song_start.emit(duration)

func _process(delta):
	# Call music_process if the track is playing.
	if music.is_playing():
		# Get variables for the current state of the song.
		var t: float = music.get_playback_position() / beatmap.get_speed_mult()
		var sd: int = beatmap.get_subdivision(t)
		
		# Run music process.
		music_process(t)
		
		# Process all subdivisions.
		for process_sd in range(current_sd, sd + 1):
			var spawn: int = beatmap.get_spawned_subdivisions(process_sd)
			subdivision_process(process_sd, spawn)
		current_sd = sd + 1

### Getters ###

func get_beatmap() -> Beatmap:
	return beatmap

func get_t() -> float:
	return music.get_playback_position() / beatmap.get_speed_mult()

### Useful Converters ###

func get_rational_subdivision() -> float:
	# Returns a floating point subdivision.
	# Seconds -> SDs
	# Seconds | Beats  | Minute  | SDs
	#         x ------ x ------- x ----
	#         | Minute | Seconds | Beat
	var time = get_t()
	var bpm = get_beatmap().get_bpm()
	var sdsbeat = get_beatmap().get_map_SD()
	return time * (bpm / 60.0) * float(sdsbeat)

### Music Logic ###

func music_process(t: float):
	pass
	
func subdivision_process(sd: int, spawn: int):
	# Perform all actions.
	for action in beatmap.get_actions(sd):
		var sig: Signal = action2signal.get(action.get_type())
		var args = action.get_args()
		match args.size():
			0:
				sig.emit()
			1:
				sig.emit(args[0])
			2:
				sig.emit(args[0], args[1])
			3:
				sig.emit(args[0], args[1], args[2])
			4:
				sig.emit(args[0], args[1], args[2], args[3])
			5:
				sig.emit(args[0], args[1], args[2], args[3], args[4])
	
	# Emit the subdivision signal.
	subdivision.emit(sd)

func music_finish():
	pass
