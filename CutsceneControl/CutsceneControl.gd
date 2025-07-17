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
	image.custom_minimum_size = DisplayServer.screen_get_size()
	image.size = DisplayServer.screen_get_size()
	#image.global_position = 
	

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "IntermediateEndings":
		#image.texture = finalEnding["coverImage"]
		anim.speed_scale = 1
		speed_up = false
		anim.play("FinalEnding")
		labelFinalTitle.visible = true
		labelFinalStory.visible = true
		image.visible = true
			

func treatEnding():
	var stichedIntermediateEndings = ""
	
	if intermediateEndings:
		for ending in intermediateEndings:
			stichedIntermediateEndings += "%s\n\n" % ending["story"]
			endIds.append(ending["id"])
			$son.text = "THE GREAT LIFE OF YOUR SON"
		
	else:
		stichedIntermediateEndings +=  "You know too well the dangers of an adventure. You’re not letting your child be in harm’s way, no matter what!

”Mom! Why you never let me do anything?!”"
		$son.text = "THE not so GREAT staying OF YOUR SON"
		
		
	endIds.append(finalEnding["id"])
	FinalEndingLoad.updateEndingUnlocked(endIds)
	
	var unlocked = FinalEndingLoad.endingUnlocked.size()
	var total = FinalEndingLoad.endingData.size()
	
	labelIntermediate.text = stichedIntermediateEndings
	labelFinalTitle.text = finalEnding["name"]
	labelFinalStory.text = finalEnding["story"]
	
	
	labelEndingCount.text = "%s/%s" % [str(unlocked), str(total)]
	labelEndingLocked.text = "There's still %s endings locked" % [total - unlocked]
	startAnimation()
	

func startAnimation():
	$buttons/buttonMenu.visible = false
	$buttons/buttonHouse.visible = false
	$buttons/buttonReplay.visible = false
	labelFinalTitle .visible = false
	labelFinalStory.visible = false
	image.visible = false
	labelEndingCount.set_modulate("ffffff00")
	labelEndingLocked.set_modulate("ffffff00")
	anim.play("IntermediateEndings")
	Audio.BGM(Audio.BGM_TYPE.Intermediate_Endings)
	
	
func skipIntermediate():
	if anim.current_animation == "IntermediateEndings" and not intermediateEndings:
		anim.play("FinalEnding")
		$finalTitle.visible = true
		$finalStory.visible = true
		$finalImage.visible = true
		
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if speed_up:
			anim.speed_scale = 1
			speed_up = false
		else:
			anim.speed_scale = 3
			speed_up = true


func _on_button_menu_button_down() -> void:
	Audio.SFX(Audio.SFX_TYPE.Click)
	get_tree().change_scene_to_file("res://Scenes/title.tscn")



func _on_button_house_button_down() -> void:
	Audio.SFX(Audio.SFX_TYPE.Click)
	get_tree().change_scene_to_file("res://Scenes/home.tscn")


func _on_button_replay_button_down() -> void:
	Audio.SFX(Audio.SFX_TYPE.Click)
	startAnimation()
