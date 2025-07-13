extends Node

var SFX_streamer: AudioStreamPlayer
var BGM_streamer: AudioStreamPlayer

func _ready():
	SFX_streamer = AudioStreamPlayer.new()
	SFX_streamer.process_mode = Node.PROCESS_MODE_ALWAYS # Won't be affected by pausing scene tree
	
	BGM_streamer = AudioStreamPlayer.new()
	BGM_streamer.process_mode = Node.PROCESS_MODE_ALWAYS 
	BGM_streamer.volume_db = -10.0
	
	add_child(SFX_streamer)
	add_child(BGM_streamer)

func SFX(SFX_name: String):
	SFX_streamer.pitch_scale = 1.0
	if SFX_name == "Click":
		SFX_streamer.pitch_scale += randf_range(-0.5,0.5)
		print()
		SFX_streamer.stream = load("res://Assets/Sounds/Sound Effects/Click_real.wav")
		
	elif SFX_name == "Super Click":
		print()
		SFX_streamer.stream = load("res://Assets/Sounds/Sound Effects/SuperClick_real.wav")
		
	else:
		print("Tried to play invalid effect name:", SFX_name)
		
	SFX_streamer.play()

func BGM(BGM_name: String):
	if BGM_name == "Results":
		BGM_streamer.stream = load("res://Assets/Sounds/Music/Results.mp3")
	else:
		print("Tried to play invalid track name:", BGM_name)
		
	BGM_streamer.play()

func BGM_toggle():
	if BGM_streamer.playing == true:
		BGM_streamer.stop()
	elif BGM_streamer.playing == false:
		BGM_streamer.play()



func BGM_volume_set(BGM_value: float):
	if BGM_value == -30.0:
		BGM_streamer.volume_linear = 0.0
	else:
		BGM_streamer.volume_db = BGM_value

func SFX_volume_set(SFX_value: float):
	if SFX_value == -30.0:
		SFX_streamer.volume_linear = 0.0
	else:
		SFX_streamer.volume_db = SFX_value
