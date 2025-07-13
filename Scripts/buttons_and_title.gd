extends VBoxContainer

@onready var SFX_streamer = $"../SFX"
@onready var Music_streamer = $"../Music"

func _ready():
	Music_streamer.play()
	pass

func SFX (type): # Manages all menu sounds, the usage of type allows for more sounds to be used (e.g. back, confirm)
	if type == "select":
		SFX_streamer.stream = load("res://Assets/Sounds/Select.wav")
		
	else:
		print("Tried to play invalid sound type")
		Audio.saint() # sfx managed in the global 'Audio' intended to draw attention to error
		pass
		
	SFX_streamer.play()


func _on_start_pressed():
	SFX("select")

func _on_endings_pressed():
	SFX("select")

func _on_options_pressed():
	SFX("select")

func _on_exit_pressed():
	SFX("select")
	get_tree().quit()

func _on_bgm_toggle_pressed() -> void:
	if Music_streamer.playing == true:
		Music_streamer.stop()
	elif Music_streamer.playing == false:
		Music_streamer.play()
