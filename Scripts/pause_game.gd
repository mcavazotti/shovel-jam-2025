extends Node

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	var options_menu = preload("res://Scenes/Options/options.tscn").instantiate()
	
	add_child(options_menu)
	options_menu.visible = false;
	
	if SaveNLoad.firstTime:
		print("here")
		showTutorials()
	

func _input(_event: InputEvent):
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		get_node("Options").visible = !get_node("Options").visible


func showTutorials():
	get_node("Options").visible = !get_node("Options").visible
	$"Options/TabContainer/Controls".visible = true
	get_tree().paused = !get_tree().paused
	
