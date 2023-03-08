extends RefCounted
class_name Config

# Data for a song configuration in a beatmap.
# Includes the time and various properties to configure.

var SD: int
var bpm: float
var delay: float
var mapSD: int
var speed: float


func _init(_SD: int = 0, _bpm: float = 120.0, _delay: float = 0.0,
			_mapSD: int = 12, _speed: float = 100):
	SD = _SD
	bpm = _bpm
	delay = _delay
	mapSD = _mapSD
	speed = _speed
