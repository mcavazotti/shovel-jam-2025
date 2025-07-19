extends Control

func _ready():
	Audio.Play(Audio.TRACK_ALIAS.Results)
#	for item in endings_gotten_list:
#	show image and the text on the next line :P


func _on_to_title_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Title/title.tscn")
