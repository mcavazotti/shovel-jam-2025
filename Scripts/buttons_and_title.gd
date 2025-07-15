extends VBoxContainer

func _ready():
	Audio.BGM(Audio.BGM_TYPE.Results)
	pass


func _on_start_pressed():
	Audio.SFX(Audio.SFX_TYPE.Super_Click)
	get_tree().change_scene_to_file("res://Scenes/home.tscn")
	Audio.BGM(Audio.BGM_TYPE.First_Minute)
	pass

func _on_endings_pressed():
	Audio.SFX(Audio.SFX_TYPE.Click)
	pass

func _on_options_pressed():
	Audio.SFX(Audio.SFX_TYPE.Click)
	pass

func _on_exit_pressed():
	Audio.SFX(Audio.SFX_TYPE.Click)
	get_tree().quit()

func _on_bgm_toggle_pressed():
	Audio.SFX(Audio.SFX_TYPE.Click)
	Audio.BGM_toggle()
