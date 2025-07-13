extends Control


func _on_options_pressed():
	visible = !visible


func _on_return_pressed():
	visible = false


func _on_exit_game_pressed():
	get_tree().quit()


func _on_fullscreen_pressed():
	Audio.saint()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_maximized_pressed():
	Audio.saint()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_windowed_pressed():
	Audio.saint()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
