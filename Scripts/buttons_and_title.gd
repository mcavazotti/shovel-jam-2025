extends VBoxContainer

func _ready():
	Audio.BGM(Audio.BGM_TYPE.Results)


func _on_start_pressed():
	Audio.SFX(Audio.SFX_TYPE.Super_Click)
	get_tree().change_scene_to_file("res://Scenes/home.tscn")
	Audio.BGM(Audio.BGM_TYPE.First_Minute)

func _on_endings_pressed():
	Audio.SFX(Audio.SFX_TYPE.Click)

func _on_options_pressed():
	Audio.SFX(Audio.SFX_TYPE.Click)
	get_node("/root/Control/Buttons and Title/Options_Menu/Options").visible = true
	get_tree().paused = true

func _input(_event: InputEvent):
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		get_node("/root/Control/Buttons and Title/Options_Menu/Options").visible = !get_node("/root/Control/Buttons and Title/Options_Menu/Options").visible

func _on_exit_pressed():
	Audio.SFX(Audio.SFX_TYPE.Click)
	get_tree().quit()

func _on_bgm_toggle_pressed():
	Audio.SFX(Audio.SFX_TYPE.Click)
	Audio.BGM_toggle()
