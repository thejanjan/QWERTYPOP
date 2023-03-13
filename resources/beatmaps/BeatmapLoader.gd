extends RefCounted
class_name BeatmapLoader

# The beatmap loader.
# Takes text files and converts them into a Beatmap class.

func test_beatmap() -> Beatmap:
	# A function which makes a test beatmap.
	# Make the init config.
	var initConfig = InitConfig.new(
		'Bleatmap', 'A bleatmap.',
		'res://resources/music/SUM.mp3',
		172.0, 0.0, 12, 48, 4,
	)
	
	# Make the lines.
	# _sd: int = 0, p_lyric: String = '', p_inputs: String = '', p_timings: Array[int] = []
	var lines: Array[Line] = [
		#Line.new(
		#	72,
		#	'Qwerty',
		#	'Qwerty',
		#	[0, 3, 6, 12, 15, 18], -24, 12
		#),
		#Line.new(
		#	96,
		#	'Qwerty',
		#	'Qwerty',
		#	[0, 3, 6, 12, 15, 18], -24, 12
		#),
		#Line.new(
		#	120,
		#	'Qwerty',
		#	'Qwerty',
		#	[0, 3, 6, 12, 15, 18], -24, 12
		#),
		### Frame 1 ###
		Line.new(
			192 + 144,
			'SUM',
			'SUM',
			[0, 12, 24], -48, 12
		),
		### Frame 2 ###
		Line.new(
			192 * 2,
			'Cogito Ergo Sum',
			'CogitoES',
			[0, 3, 6, 12, 15, 18, 30, 42], -12, 6
		),
		Line.new(
			192 * 2.25,
			'Cogito Ergo Sum',
			'CogitoES',
			[0, 3, 6, 12, 15, 18, 30, 42], -12, 6
		),
		Line.new(
			192 * 2.50,
			'That Magic In His Eye, Hexed Me',
			'ThatMagicInHisEHexedMe',
			[0, 3, 6, 12, 18, 21, 24, 27, 30, 36, 42,
			48 + 0,  48 + 3,  48 + 6,  48 + 12,
			48 + 18, 48 + 21, 48 + 24, 48 + 27,
			48 + 30, 48 + 36, 48 + 42], -24, 6
		),
		### Frame 3 ###
		Line.new(
			192 * 3,
			'Wizard\'s Galaxy',
			'WizardGalaxy',
			[0, 3, 6, 18, 30, 42,
			48 + 0, 48 + 3, 48 + 6, 48 + 18, 48 + 30, 48 + 42], -24, 6
		),
		Line.new(
			192 * 3.50,
			'His damned XYZZY brings forth',
			'HisdXYZZYbf',
			[0, 3, 6, 12, 18, 21, 24, 27, 30, 36, 42], -24, 6
		),
		Line.new(
			192 * 3.75,
			'PANDEMONIUM',
			'PANDEMONIUM',
			[0, 3, 6, 12, 15, 18, 21, 24, 30, 33, 36], -72, 12
		),
		### Frame 4 ###
		Line.new(
			192 * 4,
			'COGITO ERGO SUM',
			'COGITOERGOSUM',
			[6, 12, 18, 24, 30, 36, 48, 60, 66, 78, 90, 90, 90], -12, 6
		),
		Line.new(
			192 * 4.5,
			'COGITO ERGO SUM',
			'COGITOERGOSUM',
			[6, 12, 18, 24, 30, 36, 48, 60, 66, 78, 90, 90, 90], -12, 6
		),
		### Frame 5 ###
		Line.new(
			192 * 5,
			'THINK BEFORE YOU BECOME YOURSELF',
			'TBFYBCYS',
			[0, 6, 12, 20, 28, 30, 36, 42], -24, 6
		),
		Line.new(
			192 * 5.25,
			'LAST I HEARD IT HADN\'T GONE WELL',
			'LIHIHNGW',
			[0, 6, 12, 20, 28, 30, 36, 42], -24 - 48, 6
		),
		Line.new(
			192 * 5.5,
			'REACHING HEIGHTS YOU FORGOT WERE THERE',
			'RIHYFGWT',
			[0, 6, 12, 20, 28, 30, 36, 42], -12, 6
		),
		Line.new(
			192 * 5.75,
			'I THINK THEREFORE I AM',
			'ITTIA',
			[0, 6, 12, 22, 24], -12 - 48, 6
		),
		### Frame 6 ###
		Line.new(
			192 * 6,
			'Pour Please, More Please',
			'PourPleaseMorePlease',
			[0, 3, 6, 9, 12, 14, 16, 18, 20, 22,
			24, 27, 30, 33, 36, 38, 40, 42, 44, 46], -24, 6
		),
		Line.new(
			192 * 6.25,
			'Pour Please, More Please',
			'PourPleaseMorePlease',
			[0, 3, 6, 9, 12, 14, 16, 18, 20, 22,
			24, 27, 30, 33, 36, 38, 40, 42, 44, 46], -12, 6
		),
		Line.new(
			192 * 6.50,
			'His Wine Left A Grim Taste Unlike Pinot',
			'HisWineLeftAGrimTasteUnlikePinot',
			[0, 3, 6, 9, 12, 15, 18, 21,
			24, 27, 30, 33, 36, 39, 42, 45,
			48, 51, 54, 57, 60, 63, 66, 69,
			72, 75, 78, 81, 84, 87, 90, 93], -12, 6
		),
		### Frame 7 ###
		Line.new(
			192 * 7,
			'Pour Please, More Please',
			'PourPleaseMorePlease',
			[0, 3, 6, 9, 12, 14, 16, 18, 20, 22,
			24, 27, 30, 33, 36, 38, 40, 42, 44, 46], -24, 6
		),
		Line.new(
			192 * 7.25,
			'Pour Please, More Please',
			'PourPleaseMorePlease',
			[0, 3, 6, 9, 12, 14, 16, 18, 20, 22,
			24, 27, 30, 33, 36, 38, 40, 42, 44, 46], -12, 6
		),
		Line.new(
			192 * 7.50,
			'And We Watched As We Laughed And We Said',
			'AndWeWatchedAsWeLaughedAndWeSaid',
			[0, 3, 6, 9, 12, 15, 18, 21,
			24, 27, 30, 33, 36, 39, 42, 45,
			48, 51, 54, 57, 60, 63, 66, 69,
			72, 75, 78, 81, 84, 87, 90, 93], -12, 6
		),
		### Frame 8 ###
		Line.new(
			192 * 8,
			'LOREM IPSUM DOLOR SIT AMET ADIPISCING',
			'LIDSAA',
			[0, 4, 8, 12, 16, 20], -6, 6
		),
		Line.new(
			192 * 8,
			'CONSEQUET ADIPICCING SIT AMIT. EXSPECDA, TEMPUS',
			'CASAET',
			[24 + 0, 24 + 4, 24 + 8, 24 + 12, 24 + 16, 24 + 20], -6, 6
		),
		Line.new(
			192 * 8,
			'CEPISTI HOC INTERPRETANDI? MON EXSPECDABAM, TANTUM',
			'CHIMET',
			[48 + 0, 48 + 4, 48 + 8, 48 + 12, 48 + 16, 48 + 20], -6, 6
		),
		Line.new(
			192 * 8,
			'CONABAR LATINUM SENMONEM REDDERE, UT HANC',
			'CLSRUH',
			[72 + 0, 72 + 4, 72 + 8, 72 + 12, 72 + 16, 72 + 20], -6, 6
		),
		Line.new(
			192 * 8.50,
			'The Candleabra Was Losing Warm Embers',
			'TheCandleabraWasLosingWarmEmbers',
			[0, 3, 6, 9, 12, 15, 18, 21,
			24, 27, 30, 33, 36, 39, 42, 45,
			48, 51, 54, 57, 60, 63, 66, 69,
			72, 75, 78, 81, 84, 87, 90, 93], -12, 6
		),
#		### Frame 9 ###
		Line.new(
			192 * 9,
			'PARTEM CARMINIS VERE REFRIGERET. SPERO TE',
			'PCVRSTi',
			[0, 4, 8, 12, 16, 20], -6, 6
		),
		Line.new(
			192 * 9,
			'FRUENDUM ESSE, CUM VERBIS HARUM TABULARUM',
			'FECVHT',
			[24 + 0, 24 + 4, 24 + 8, 24 + 12, 24 + 16, 24 + 20], -6, 6
		),
		Line.new(
			192 * 9,
			'ASCENDENS MENS TORPENS DIFFICILIS EST. GRATIAS',
			'AMTDEG',
			[48 + 0, 48 + 4, 48 + 8, 48 + 12, 48 + 16, 48 + 20], -6, 6
		),
		Line.new(
			192 * 9,
			'TIBI AGO QUOD HOC MIHI DES.',
			'TAQHMD',
			[72 + 0, 72 + 4, 72 + 8, 72 + 12, 72 + 16, 72 + 20], -6, 6
		),
		Line.new(
			192 * 9.50,
			'And Yet He Prepared One Last Spellcast',
			'AndYetHePreparedOneLastSpellcast',
			[0, 3, 6, 9, 12, 15, 18, 21,
			24, 27, 30, 33, 36, 39, 42, 45,
			48, 51, 54, 57, 60, 63, 66, 69,
			72, 75, 78, 81, 84, 87, 90, 93], -12, 6
		),
		### Frame 10 ###
		Line.new(
			192 * 10,
			'OPEN UP YOUR EYES',
			'OPEUPYOEY',
			[6, 18, 18, 24, 24,
			33, 33, 42, 42], -6, 6
		),
		Line.new(
			192 * 10,
			'SHUT YOUR BRAIN DOWN',
			'SHYOBRDO',
			[48 + 6, 48 + 6, 48 + 18, 48 + 18,
			48 + 24, 48 + 24, 48 + 36, 48 + 36], -6, 6
		),
		Line.new(
			192 * 10,
			'MOTION OF BLUE SKIES',
			'MOTIOFBLSK',
			[96 + 6, 96 + 6, 96 + 18, 96 + 18, 96 + 24, 96 + 24,
			96 + 33, 96 + 33, 96 + 42, 96 + 42], -6, 6
		),
		Line.new(
			192 * 10,
			'NOW A RAIN CLOUD',
			'NOARACL',
			[144 + 6, 144 + 6, 144 + 18,
			144 + 24, 144 + 24, 144 + 36, 144 + 36], -6, 6
		),
		### Frame 11 ###
		Line.new(
			192 * 11,
			'FERROMAGNETIC',
			'FEROMANETI',
			[6, 6, 18, 18, 24, 24,
			33, 33, 42, 42], -12, 6
		),
		Line.new(
			192 * 11,
			'IRON COMPOUND',
			'IROCOPO',
			[48 + 6, 48 + 18, 48 + 18,
			48 + 24, 48 + 24, 48 + 36, 48 + 36], -12, 6
		),
		Line.new(
			192 * 11,
			'MONOCHROMATIC',
			'MONOCHMATI',
			[96 + 6, 96 + 6, 96 + 18, 96 + 18, 96 + 24, 96 + 24,
			96 + 33, 96 + 33, 96 + 42, 96 + 42], -12, 6
		),
		Line.new(
			192 * 11,
			'SENSURROUND SOUND',
			'SESUROSO',
			[144 + 6, 144 + 6, 144 + 18, 144 + 18,
			144 + 24, 144 + 24, 144 + 36, 144 + 36], -12, 6
		),
		### Frame 12 ###
		Line.new(
			192 * 12,
			'Once Upon A   Time',
			'OUAT',
			[(48 * 0) + 0,
			(48 * 1) + 0,
			(48 * 2) + 0,
			(48 * 3) + 0], -12, 6
		),
		Line.new(
			192 * 12,
			'I    once was whole',
			'Ioww',
			[(48 * 0) + 8,
			(48 * 1) + 8,
			(48 * 2) + 8,
			(48 * 3) + 8], -12, 6
		),
		Line.new(
			192 * 12,
			'Was  came thy eat',
			'Wcte',
			[(48 * 0) + 18,
			(48 * 1) + 18,
			(48 * 2) + 18,
			(48 * 3) + 18], -12, 6
		),
		Line.new(
			192 * 12,
			'I    then was me',
			'Itwm',
			[(48 * 0) + 24,
			(48 * 1) + 24,
			(48 * 2) + 24,
			(48 * 3) + 24], -12, 6
		),
		### Frame 13 ###
		Line.new(
			192 * 13,
			'Stunned We   Had    Wrote',
			'SWHW',
			[(48 * 0) + 0,
			(48 * 1) + 0,
			(48 * 2) + 0,
			(48 * 3) + 0], -12, 6
		),
		Line.new(
			192 * 13,
			'Was     left not    right',
			'Wlnr',
			[(48 * 0) + 8,
			(48 * 1) + 8,
			(48 * 2) + 8,
			(48 * 3) + 8], -12, 6
		),
		Line.new(
			192 * 13,
			'The     we   what\'s from',
			'Twwf',
			[(48 * 0) + 18,
			(48 * 1) + 18,
			(48 * 2) + 18,
			(48 * 3) + 18], -12, 6
		),
		Line.new(
			192 * 13,
			'Man     came for    us',
			'Mcfu',
			[(48 * 0) + 24,
			(48 * 1) + 24,
			(48 * 2) + 24,
			(48 * 3) + 24], -12, 6
		),
		### Frame 14 ###
		Line.new(
			192 * 14,
			'Too   Tired To    Move',
			'TTTM',
			[(48 * 0) + 0,
			(48 * 1) + 0,
			(48 * 2) + 0,
			(48 * 3) + 0], -12, 6
		),
		Line.new(
			192 * 14,
			'Fry\'d eyes  dance \'round',
			'Fedr',
			[(48 * 0) + 8,
			(48 * 1) + 8,
			(48 * 2) + 8,
			(48 * 3) + 8], -12, 6
		),
		Line.new(
			192 * 14,
			'To    gaze  wi\'h  the',
			'Tgwt',
			[(48 * 0) + 18,
			(48 * 1) + 18,
			(48 * 2) + 18,
			(48 * 3) + 18], -12, 6
		),
		Line.new(
			192 * 14,
			'Think on    stars wings',
			'Tosw',
			[(48 * 0) + 24,
			(48 * 1) + 24,
			(48 * 2) + 24,
			(48 * 3) + 24], -12, 6
		),
		### Frame 15 ###
		Line.new(
			192 * 15,
			'FOUND OURSELVES A HARMONY',
			'FOSAHMY',
			[0, 9, 12, 18, 24, 30, 36], -12, 6
		),
		Line.new(
			192 * 15.25,
			'DANCE AROUND THE STARS',
			'DARTS',
			[0, 9, 12, 18, 24], -12, 6
		),
		Line.new(
			192 * 15.5,
			'LEFT OURSELVES A LEGACY',
			'LOSALAC',
			[0, 9, 12, 18, 24, 30, 36], -12, 6
		),
		Line.new(
			192 * 15.75,
			'HOME UPON THE MILKY WAY',
			'HUPTMKW',
			[0, 9, 12, 18, 24, 30, 36], -12, 6
		),
		### Frame 16 ###
		Line.new(
			192 * 16,
			'Man has not come back for us but we',
			'Mhncbfubw',
			[0, 9, 12, 18, 24, 30, 36, 42, 45], -12, 6
		),
		Line.new(
			192 * 16.25,
			'fear the day he does.',
			'ftdhd',
			[0, 9, 12, 18, 24], -6, 6
		),
		Line.new(
			192 * 16.50,
			'Man has not come back for us but we',
			'Mhncbfubw',
			[0, 9, 12, 18, 24, 30, 36, 42, 45], -12, 6
		),
		Line.new(
			192 * 16.75,
			'fear the day he does.',
			'ftdhd',
			[0, 9, 12, 18, 24], -6, 6
		),
		### Frame 17 ###
		Line.new(
			192 * 17,
			'Will never be I again',
			'WnvbIag',
			[0, 9, 12, 18, 24, 30, 36], -12, 6
		),
		Line.new(
			192 * 17.25,
			'but we like it here',
			'bwlih',
			[0, 9, 12, 18, 24], -12, 6
		),
		Line.new(
			192 * 17.5,
			'Together we\'re whole as one',
			'Tgtwwao',
			[0, 9, 12, 18, 24, 30, 36], -12, 6
		),
		Line.new(
			192 * 17.75,
			'Think, therefore we are',
			'Ttfwa',
			[0, 9, 18, 24, 36], -12, 6
		),
	]
	
	# Make the configs.
	var configs: Array[Config] = []
	
	# Return the beatmap.
	return Beatmap.new(initConfig, lines, configs)
