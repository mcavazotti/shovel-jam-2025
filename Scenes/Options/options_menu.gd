extends Control


func _on_return_pressed():
	get_tree().paused = false
	visible = false


func _on_fullscreen_pressed():
	Audio.Play(Audio.TRACK_ALIAS.Click)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_maximized_pressed():
	Audio.Play(Audio.TRACK_ALIAS.Click)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_windowed_pressed():
	Audio.Play(Audio.TRACK_ALIAS.Click)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_bgm_slider_drag_ended(_BGM_value_changed: bool):
	Audio.BGM_volume_set($"TabContainer/Audio/Buttons and Title/BGM Slider".value)


func _on_sfx_slider_drag_ended(_SFX_value_changed: bool):
	Audio.SFX_volume_set($"TabContainer/Audio/Buttons and Title/SFX Slider".value)


func _on_amb_slider_drag_ended(_AMB_value_changed: bool):
	Audio.AMB_volume_set($"TabContainer/Audio/Buttons and Title/AMB Slider".value)


func _on_to_title_pressed():
	Audio.BGM_stream.stop()
	Audio.AMB_stream.stop()
	get_tree().change_scene_to_file("res://Scenes/Title/title.tscn")
