extends Control


@onready var anim = $anim
@onready var image = $finalImage
@onready var labelIntermediate = $intermediate 
@onready var labelFinalTitle = $finalTitle
@onready var labelFinalStory = $finalStory
@onready var labelEndingCount = $buttons/endingCount
@onready var labelEndingLocked = $buttons/endingLocked

var endIds = []
var intermediateEndings
var finalEnding
var speed_up = false


func _ready() -> void:
	endIds.clear()
	var screen_size = DisplayServer.screen_get_size()
	image.custom_minimum_size = screen_size
	

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "IntermediateEndings":
		anim.speed_scale = 1
		speed_up = false
		anim.play("FinalEnding")
		$finalTitle.visible = true
		$finalStory.visible = true
		$finalImage.visible = true
			

func treatEnding():
	var stichedIntermediateEndings = ""
	
	if intermediateEndings:
		for ending in intermediateEndings:
			stichedIntermediateEndings += "%s\n\n" % ending["story"]
			endIds.append(ending["id"])
		
	else:
		stichedIntermediateEndings += "Your child didn't started his adventure yet..."
		
		endIds.append(finalEnding["id"])
		FinalEndingLoad.updateEndingUnlocked(endIds)
	
	var unlocked = FinalEndingLoad.endingUnlocked.size()
	var total = FinalEndingLoad.endingData.size()
	
	labelIntermediate.text = stichedIntermediateEndings
	labelEndingCount.text = "%s/%s" % [str(unlocked), str(total)]
	labelEndingLocked.text = "There's still %s endings locked" % [total - unlocked]
	startAnimation()
	

func startAnimation():
	$buttons/buttonMenu.visible = false
	$buttons/buttonHouse.visible = false
	$buttons/buttonReplay.visible = false
	$finalTitle.visible = false
	$finalStory.visible = false
	$finalImage.visible = false
	anim.play("IntermediateEndings")
	
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if speed_up:
			anim.speed_scale = 1
			speed_up = false
		else:
			anim.speed_scale = 3
			speed_up = true


func _on_button_menu_button_down() -> void:
	pass
	#pass menu scene


func _on_button_house_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/House.tscn")


func _on_button_replay_button_down() -> void:
	startAnimation()


func skipIntermediate():
	if anim.current_animation == "IntermediateEndings" and not intermediateEndings:
		print("Skipped")
		anim.play("FinalEnding")
		$finalTitle.visible = true
		$finalStory.visible = true
		$finalImage.visible = true
