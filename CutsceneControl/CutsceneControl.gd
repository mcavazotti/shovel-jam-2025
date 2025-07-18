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
var paused = false
var speedOriginal : int


func _ready() -> void:
	endIds.clear()
	image.custom_minimum_size = DisplayServer.screen_get_size()
	

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
			
	elif (not intermediateEndings) and FinalEndingLoad.itemsBackpack: #This will also trigger if there's no intermidiate ending
		stichedIntermediateEndings +=  "You know too well the dangers of an adventure. But you decide to let your son life his adventures anyway.
		
From time to time you heard a few news about him...”"
		
	elif not intermediateEndings:
		stichedIntermediateEndings += "You know too well the dangers of an adventure. You’re not letting your child be in harm’s way, no matter what!

”Mom! Why you never let me do anything?!”"
		
		
	endIds.append(finalEnding["id"])
	FinalEndingLoad.updateEndingUnlocked(endIds)
	
	var unlocked = SaveNLoad.endingUnlocked
	var sizeUnlocked = unlocked.size()
	var total = FinalEndingLoad.endingData.size()
	
	labelIntermediate.text = stichedIntermediateEndings
	labelFinalTitle.text = finalEnding["name"]
	labelFinalStory.text = finalEnding["story"]
	
	
	labelEndingCount.text = "%s/%s" % [str(sizeUnlocked), str(total)]
	labelEndingLocked.text = "There's still %s endings locked" % [total - sizeUnlocked]
	print(SaveNLoad.endingUnlocked)
	SaveNLoad.save_game()
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
	Audio.Play(Audio.TRACK_ALIAS.Intermediate_Endings)
	
	
func skipIntermediate():
	if anim.current_animation == "IntermediateEndings" and not intermediateEndings:
		anim.play("FinalEnding")
		$finalTitle.visible = true
		$finalStory.visible = true
		$finalImage.visible = true
		
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_text_submit"): # ENTER
		speed_up = !speed_up
		if not speed_up and not paused:
			anim.speed_scale = 1
			$GPUParticles2D_Right.speed_scale = 1
			$GPUParticles2D_Left.speed_scale = 1
			speedOriginal = $GPUParticles2D_Right.speed_scale
		elif speed_up and not paused:
			anim.speed_scale = 3
			$GPUParticles2D_Right.speed_scale = 3
			$GPUParticles2D_Left.speed_scale = 3
			speedOriginal = $GPUParticles2D_Right.speed_scale	
				
		#dont place speedOriginal out of If, might mess with Particles
	
	elif event.is_action_pressed("ui_select"):
		paused = !paused
		if paused:
			$GPUParticles2D_Right.speed_scale = 0.1
			$GPUParticles2D_Left.speed_scale = 0.1
		else:
			$GPUParticles2D_Left.speed_scale = speedOriginal
			$GPUParticles2D_Right.speed_scale = speedOriginal
		anim.playback_active = !anim.playback_active
		

func _on_button_menu_button_down() -> void:
	Audio.Play(Audio.TRACK_ALIAS.Click)
	get_tree().change_scene_to_file("res://Scenes/title.tscn")



func _on_button_house_button_down() -> void:
	Audio.Play(Audio.TRACK_ALIAS.Click)
	get_tree().change_scene_to_file("res://Scenes/home.tscn")


func _on_button_replay_button_down() -> void:
	Audio.Play(Audio.TRACK_ALIAS.Click)
	startAnimation()
