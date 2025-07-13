extends VBoxContainer

func _ready():
	Audio.BGM("Results")
	pass


func _on_start_pressed():
	Audio.SFX("Super Click")
	pass

func _on_endings_pressed():
	Audio.SFX("Click")
	pass

func _on_options_pressed():
	Audio.SFX("Click")
	pass

func _on_exit_pressed():
	Audio.SFX("Click")
	get_tree().quit()

func _on_bgm_toggle_pressed():
	Audio.SFX("Click")
	Audio.BGM_toggle()
