extends VBoxContainer

@onready var SFX_streamer = $"../SFX"

func SFX (type): # Manages all menu sounds
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
