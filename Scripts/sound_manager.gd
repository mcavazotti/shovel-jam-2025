extends Node

var SFX_stream: AudioStreamPlayer
var BGM_stream: AudioStreamPlayer
var AMB_stream: AudioStreamPlayer

func _ready():
	SFX_stream = AudioStreamPlayer.new()
	SFX_stream.process_mode = Node.PROCESS_MODE_ALWAYS
	
	BGM_stream = AudioStreamPlayer.new()
	BGM_stream.process_mode = Node.PROCESS_MODE_ALWAYS 
	BGM_stream.volume_db = -10.0
	
	AMB_stream = AudioStreamPlayer.new()
	AMB_stream.process_mode = Node.PROCESS_MODE_ALWAYS 
	
	add_child(SFX_stream)
	add_child(BGM_stream)
	add_child(AMB_stream)

enum TRACK_ALIAS {
	# SOUND EFFECTS
	Click,
	Super_Click,
	# BACKGROUND MUSIC
	Results,
	First_Minute,
	Second_Minute,
	# AMBIENCE
	AMB_1,
	AMB_2,
	AMB_3,
	AMB_4
}

func Play(Track_name: TRACK_ALIAS):
	SFX_stream.pitch_scale = 1.0
	
	# Sound effects
	if Track_name == TRACK_ALIAS.Click:
		SFX_stream.pitch_scale += randf_range(-0.5,0.5)
		print()
		SFX_stream.stream = load("res://Assets/Sounds/Sound Effects/Click_real.wav")
		SFX_stream.play()
		
	elif Track_name == TRACK_ALIAS.Super_Click:
		print()
		SFX_stream.stream = load("res://Assets/Sounds/Sound Effects/SuperClick_real.wav")
		SFX_stream.play()
		
	# Background Music
	elif Track_name == TRACK_ALIAS.Results:
		BGM_stream.stream = load("res://Assets/Sounds/Music/Results.mp3")
		BGM_stream.play()
		
	elif Track_name == TRACK_ALIAS.First_Minute:
		BGM_stream.stream = load("res://Assets/Sounds/Music/Time and time again.mp3")
		BGM_stream.play()
		
	# Ambience
	elif Track_name == TRACK_ALIAS.AMB_1:
		AMB_stream.stream = load("res://Assets/Sounds/Ambience/AMB_1.wav")
		AMB_stream.play()
		
	elif Track_name == TRACK_ALIAS.AMB_2:
		AMB_stream.stream = load("res://Assets/Sounds/Ambience/AMB_2.wav")
		AMB_stream.play()
		
	elif Track_name == TRACK_ALIAS.AMB_3:
		AMB_stream.stream = load("res://Assets/Sounds/Ambience/AMB_3.wav")
		AMB_stream.play()
		
	elif Track_name == TRACK_ALIAS.AMB_4:
		AMB_stream.stream = load("res://Assets/Sounds/Ambience/AMB_4.wav")
		AMB_stream.play()
		
	else:
		print("Tried to play nonexistent track:", Track_name)

func BGM_toggle():
	if BGM_stream.playing == true:
		BGM_stream.stop()
	elif BGM_stream.playing == false:
		BGM_stream.play()

func BGM_volume_set(BGM_value: float):
	if BGM_value == -30.0:
		BGM_stream.volume_linear = 0.0
	else:
		BGM_stream.volume_db = BGM_value

func SFX_volume_set(SFX_value: float):
	if SFX_value == -30.0:
		SFX_stream.volume_linear = 0.0
	else:
		SFX_stream.volume_db = SFX_value

func AMB_volume_set(AMB_value: float):
	if AMB_value == -30.0:
		AMB_stream.volume_linear = 0.0
	else:
		AMB_stream.volume_db = AMB_value
