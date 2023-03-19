extends Node3D
class_name BeatmapWorld

# The BeatmapWorld.
# Handles all visual background aspects of the Beatmap.

@onready var beatmap_manager = $"../BeatmapManager"


signal subdivision(sd: int)

func _ready():
	beatmap_manager.subdivision.connect(func (sd: int): subdivision.emit(sd))
