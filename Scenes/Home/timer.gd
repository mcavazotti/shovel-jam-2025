extends CanvasLayer

@onready var elapsed_time: int = 0

func _ready():
	$Timer.start()

func _on_timer_timeout():
	elapsed_time += 1
	if elapsed_time < 121:
		$TimerLabel.text = str(120-elapsed_time)
	if elapsed_time == 99:
		$TimerLabel.text = str(120-elapsed_time)
		Audio.Play(Audio.TRACK_ALIAS.Second_Minute)
		
		
	if elapsed_time == 123:
		Audio.BGM_stream.stop()
		Audio.AMB_stream.stop()
		$"../ExitHouse".getItems()
		get_tree().change_scene_to_file("res://Scenes/gameOverCutscenes.tscn")
