extends Node

var audio_stream_player: AudioStreamPlayer

# This script is a global that makes testing a bit easier by playing a 'ping' sound when called
# I can remove this upon request but I find it helpful for testing quickly

func _ready():
	audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(audio_stream_player)

func saint(): # function to call anywhere to test functionallity via Audio.saint()
	audio_stream_player.stream = load("res://Assets/Sounds/Ping.wav")
	audio_stream_player.play()
