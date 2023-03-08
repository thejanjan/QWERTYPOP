extends RefCounted
class_name BeatmapLoader

# The beatmap loader.
# Takes text files and converts them into a Beatmap class.

func test_beatmap() -> Beatmap:
	# A function which makes a test beatmap.
	# Make the init config.
	var initConfig = InitConfig.new(
		'Bleatmap', 'A bleatmap.',
		'res://resources/music/bpm_test.wav',
		120.0, 0.0, 6, 12,
		InitConfig.BeatmapDifficulty.EASY
	)
	
	# Make the lines.
	# _sd: int = 0, p_lyric: String = '', p_inputs: String = '', p_timings: Array[int] = []
	var lines: Array[Line] = [
		Line.new(
			24,
			'what is this song?',
			'whatisthiss',
			[4, 12, 24, 34, 52, 60, 69, 70, 71, 72, 82]
		),
		Line.new(
			120,
			'think i heard this before, think i heard this before',
			'thinkihtbfthinkihtbf',
			[4, 6, 10, 12, 16, 22, 28, 34, 40, 42, 52, 54, 58, 60, 64, 70, 76, 82, 88, 90]
		)
	]
	
	# Make the configs.
	var configs: Array[Config] = []
	
	# Return the beatmap.
	return Beatmap.new(initConfig, lines, configs)
