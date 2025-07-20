extends Control

@onready var anim = $anim
@onready var animImage = $animImage
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
var indexImages: int = 0
var interImages:Array 
var textureRects:Array

func _ready() -> void:
	endIds.clear()
	image.custom_minimum_size = DisplayServer.screen_get_size()
	textureRects = get_tree().get_nodes_in_group("InterImages")
	print("Texture Rects: ", textureRects)
	speedOriginal = 1


func finalAnimStart() -> void:
	#image.texture = finalEnding["coverImage"]
	anim.speed_scale = anim.speed_scale
	Audio.Play(Audio.TRACK_ALIAS.Final_Ending)
	anim.play("FinalEnding")
	labelFinalTitle.visible = true
	labelFinalStory.visible = true
	image.visible = true


func treatEnding():
	var endingsCount = 0
	var stichedIntermediateEndings = ""
	
	if intermediateEndings:
		for ending in intermediateEndings:
			stichedIntermediateEndings += "%s\n\n" % ending["story"]
			endIds.append(ending["id"])
		
			$son.text = "THE GREAT LIFE OF YOUR SON"
			endingsCount += 1
			
			interImages.append(ending["coverImage"])
			
	elif (not intermediateEndings) and FinalEndingLoad.itemsBackpack: #This will also trigger if there's no intermidiate ending
		stichedIntermediateEndings +=  "You know all too well the dangers of adventure. However, you decide to let your son journey on a quest of his own in hopes he finds his place in the world.
		
From time to time you heard a few news about him...”"
		
	elif not intermediateEndings:
		interImages.append("")
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

	SaveNLoad.save_game()
	skipIntermediateUpdate(endingsCount)
	
	updateIntermediateImages() #FIRST RUN IN SCENE. (IMPORTANT BE HERE)
	startAnimation()


func updateIntermediateImages():
	print("InterImages: ", interImages)
	for texRect in textureRects:
		if indexImages < interImages.size():
			print("Texture Rect", texRect)
			#texRect.texture = interImages[indexImages]
			print("TEXTURE RECT CHANGED IMAGE OK")
			indexImages += 1


func playImages():
	animImage.play("ImagesFadeInOut")


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
	finalAnimStart()


func skipIntermediateUpdate(iE):
	if iE > 1:
		var intermiediateAnimation = anim.get_animation("IntermediateEndings")
		var methodTrackIndex := -1

		for i in intermiediateAnimation.get_track_count():
			if intermiediateAnimation.track_get_type(i) == Animation.TYPE_METHOD:
				methodTrackIndex = i
				break

		if methodTrackIndex != -1:
			var oldTime = 17
			var newTime = int(oldTime + (2 * iE))

			var keyIndex = intermiediateAnimation.track_find_key(methodTrackIndex, oldTime)
			print(keyIndex)
			
			if keyIndex != -1:
				intermiediateAnimation.track_set_key_time(methodTrackIndex, keyIndex, newTime)
				print("Moved method key from", oldTime, "to", newTime)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_text_submit"): # ENTER
		speed_up = !speed_up
		if not speed_up and not paused:
			
			anim.speed_scale = 1
			animImage.speed_scale = 1
			$GPUParticles2D_Right.speed_scale = 1
			$GPUParticles2D_Left.speed_scale = 1
			speedOriginal = $GPUParticles2D_Right.speed_scale
		#dont place speedOriginal out of If, might mess with Particles
		elif speed_up and not paused:
			
			anim.speed_scale = 3
			animImage.speed_scale = 3
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
		animImage.playback_active = !animImage.playback_active
		
		
func _on_button_menu_button_down() -> void:
	Audio.Play(Audio.TRACK_ALIAS.Click)
	get_tree().change_scene_to_file("res://Scenes/Title/title.tscn")
	Audio.BGM_stream.stop()

func _on_button_house_button_down() -> void:
	Audio.Play(Audio.TRACK_ALIAS.Click)
	Audio.BGM_stream.stop()
	Audio.Play(Audio.TRACK_ALIAS.First_Minute)
	Audio.Play(Audio.TRACK_ALIAS.AMB_1)
	get_tree().change_scene_to_file("res://Scenes/Home/home.tscn")

func _on_button_replay_button_down() -> void:
	indexImages = 0
	Audio.Play(Audio.TRACK_ALIAS.Click)
	startAnimation()
