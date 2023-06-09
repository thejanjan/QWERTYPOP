extends RefCounted
class_name InitConfig

# A resource for the initial song configuration for a beatmap.
# Includes various properties to configure.

var name: String
var desc: String
var song: String
var bpm: float
var delay: float
var mapSD: int
var speed: float
var window: int
var speed_mult: float


func _init(_name: String = 'Bleatmap', _desc: String = 'A bleatmap.',
			_song: String = 'res://resources/music/bpm_test.wav',
			_bpm: float = 120.0, _delay: float = 0.0,
			_mapSD: int = 12, _speed: int = 12,
			_window: int = 3, _speed_mult: float = 1.00):
	name = _name
	desc = _desc
	song = _song
	bpm = _bpm
	delay = _delay
	mapSD = _mapSD
	speed = _speed
	window = _window
	speed_mult = _speed_mult

### Simple Getters ###

func get_map_name() -> String:
	return name

func get_map_desc() -> String:
	return desc

func get_song_path() -> String:
	return song

func get_bpm() -> float:
	return bpm * speed_mult

func get_delay() -> float:
	return delay

func get_map_SD() -> int:
	return mapSD

func get_scroll_speed() -> float:
	return speed

func get_timing_window() -> int:
	return window

func get_speed_mult() -> float:
	return speed_mult

### Getters ###

func get_audio_stream() -> AudioStream:
	return load(get_song_path())
