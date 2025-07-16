extends Control


@onready var anim = $anim
@onready var image = $finalImage
@onready var labelIntermediate = $intermediate 
@onready var labelFinalTitle = $finalTitle
@onready var labelFinalStory = $finalStory

var endIds = []
var intermediateEndings
var finalEnding
var speed_up = false


func _ready() -> void:
	var screen_size = DisplayServer.screen_get_size()
	image.custom_minimum_size = screen_size
	
	

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "IntermediateEndings":
		anim.play("FinalEnding")


func treatEnding():
	var stichedIntermediateEndings = ""
	for ending in intermediateEndings:
		stichedIntermediateEndings += "%s\n\n" % ending["story"]
	print(stichedIntermediateEndings)
	labelIntermediate.text = stichedIntermediateEndings
	startAnimation()
	

func startAnimation():
	anim.play("IntermediateEndings")
	
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if speed_up:
			anim.speed_scale = 1
			speed_up = false
		else:
			anim.speed_scale = 3
			speed_up = true
		
