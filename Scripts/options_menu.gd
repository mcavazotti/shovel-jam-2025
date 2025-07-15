extends Control


func _on_options_pressed():
	get_tree().paused = true
	visible = true


func _on_return_pressed():
	get_tree().paused = false
	visible = false


func _on_exit_game_pressed():
	get_tree().quit()


func _on_fullscreen_pressed():
	Audio.SFX(Audio.SFX_TYPE.Click)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_maximized_pressed():
	Audio.SFX(Audio.SFX_TYPE.Click)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_windowed_pressed():
	Audio.SFX(Audio.SFX_TYPE.Click)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_tab_container_tab_changed(tab: int):
	if tab == 3:
		visible = false
		$TabContainer.current_tab = 0


func _on_bgm_slider_drag_ended(_BGM_value_changed: bool):
	Audio.BGM_volume_set($"TabContainer/Audio/Buttons and Title/BGM Slider".value)


func _on_sfx_slider_drag_ended(_SFX_value_changed: bool):
	Audio.SFX_volume_set($"TabContainer/Audio/Buttons and Title/SFX Slider".value)
