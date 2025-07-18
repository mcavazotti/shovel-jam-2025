extends Node

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	var options_menu = preload("res://Scenes/options.tscn").instantiate()
	
	add_child(options_menu)
	options_menu.visible = false;
	

func _input(_event: InputEvent):
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		get_node("Options").visible = !get_node("Options").visible
