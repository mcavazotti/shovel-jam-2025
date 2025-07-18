extends VBoxContainer

func _ready():
	Audio.Play(Audio.TRACK_ALIAS.Results)


func _on_start_pressed():
	Audio.Play(Audio.TRACK_ALIAS.Super_Click)
	get_tree().change_scene_to_file("res://Scenes/home.tscn")
	Audio.Play(Audio.TRACK_ALIAS.First_Minute)
	Audio.Play(Audio.TRACK_ALIAS.AMB_1)

func _on_endings_pressed():
	Audio.Play(Audio.TRACK_ALIAS.Click)

func _on_options_pressed():
	Audio.Play(Audio.TRACK_ALIAS.Click)
	get_node("/root/Control/Buttons and Title/Options_Menu/Options").visible = true
	get_tree().paused = true

func _input(_event: InputEvent):
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		get_node("/root/Control/Buttons and Title/Options_Menu/Options").visible = !get_node("/root/Control/Buttons and Title/Options_Menu/Options").visible

func _on_exit_pressed():
	Audio.Play(Audio.TRACK_ALIAS.Click)
	SaveNLoad.save_game()
	get_tree().quit()

func _on_bgm_toggle_pressed():
	Audio.Play(Audio.TRACK_ALIAS.Click)
	Audio.BGM_toggle()
