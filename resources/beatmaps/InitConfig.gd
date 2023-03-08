extends RefCounted
class_name InitConfig

enum BeatmapDifficulty {EASY = 100, MEDIUM = 50, HARD = 25}

# A resource for the initial song configuration for a beatmap.
# Includes various properties to configure.

var name: String
var desc: String
var song: String
var bpm: float
var delay: float
var mapSD: int
var speed: float
var window: BeatmapDifficulty


func _init(_name: String = 'Bleatmap', _desc: String = 'A bleatmap.',
			_song: String = 'res://resources/music/bpm_test.wav',
			_bpm: float = 120.0, _delay: float = 0.0,
			_mapSD: int = 12, _speed: int = 6,
			_window: BeatmapDifficulty = BeatmapDifficulty.EASY):
	name = _name
	desc = _desc
	song = _song
	bpm = _bpm
	delay = _delay
	mapSD = _mapSD
	speed = _speed
	window = _window

### Simple Getters ###

func get_map_name() -> String:
	return name

func get_map_desc() -> String:
	return desc

func get_song_path() -> String:
	return song

func get_bpm() -> float:
	return bpm

func get_delay() -> float:
	return delay

func get_map_SD() -> int:
	return mapSD

func get_scroll_speed() -> float:
	return speed

func get_timing_ms() -> float:
	return window

### Getters ###

func get_audio_stream() -> AudioStream:
	return load(get_song_path())
