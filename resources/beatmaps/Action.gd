extends RefCounted
class_name Action

enum Type {
	SPAWN_KEY,
	PRESS_KEY,
	START_LINE,
	END_LINE,
	OPEN_WINDOW,
	CLOSE_WINDOW,
	SPAWN_LION,
}

# A class for describing an action.
# Determines what action the BeatmapManager should take
# on a given subdivision.

var type: Type
var args: Array[Variant]


func _init(_type: Type, _args: Array[Variant] = []):
	type = _type
	args = _args

### Getters ###

func get_type() -> Type:
	return type

func get_args() -> Array[Variant]:
	return args
