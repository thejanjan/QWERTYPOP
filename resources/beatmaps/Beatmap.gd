extends RefCounted
class_name Beatmap

# A beatmap.
# Consists of an InitConfig, an array of Lines, and
# an array of more Configs to change things as necessary.

var initConfig: InitConfig
var lines: Array[Line]
var configs: Array[Config]

func _init(_initConfig: InitConfig, _lines: Array[Line], _configs: Array[Config]):
	initConfig = _initConfig
	lines = _lines
	configs = _configs
	
### Property Getters ###

func get_bpm() -> float:
	return initConfig.get_bpm()

func get_map_SD() -> int:
	return initConfig.get_map_SD()

func get_scroll_speed() -> int:
	return initConfig.get_scroll_speed()
	
func get_timing_window() -> int:
	return initConfig.get_timing_window()

func get_speed_mult() -> float:
	return initConfig.get_speed_mult()

### Time Getters ###

func get_subdivision(t: float = 0.0) -> int:
	# Given a time, return the current subdivision.
	var bpm = initConfig.get_bpm()
	var delay = initConfig.get_delay()
	var sds = initConfig.get_map_SD()
	return round((bpm / 60) * (t - delay) * sds)

func get_spawned_subdivisions(sd: int) -> int:
	# Given a subdivision, get the latest subdivision that should be spawned.
	return sd + initConfig.get_scroll_speed()
	
### Line Getters ###

func get_actions(sd: int) -> Array[Action]:
	var actions: Array[Action] = []
	for line in lines:
		actions.append_array(line.get_actions(sd, self))
	
	# Spawn a lion if need be.
	if (sd % (get_map_SD())) == 0:
		actions.append(Action.new(Action.Type.SPAWN_LION, [sd + (get_map_SD() * 5)]))
	
	return actions

### Actions ###

func get_audio_stream() -> AudioStream:
	return initConfig.get_audio_stream()
