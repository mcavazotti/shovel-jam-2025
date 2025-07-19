extends Control

@onready var unlocked = SaveNLoad.endingUnlocked
@onready var sizeUnlocked = unlocked.size()
@onready var total = FinalEndingLoad.endingData.size()
@onready var endingData = FinalEndingLoad.endingData

func get_ending_name_and_story_and_image(id):
	for ending in endingData:
		if ending["id"] == id:
			return {"name": ending["name"], "story": ending["story"], "coverImage": ending["coverImage"]}

func _ready():
	Audio.Play(Audio.TRACK_ALIAS.Results)
	var endingCount = $"ScrollContainer/Endings List/Count"
	endingCount.text = "%s/%s" % [str(sizeUnlocked), str(total)]
	
	for endings in unlocked:
		var hBox = HBoxContainer.new()
		#var textureRect = TextureRect.new()
		var nameLabel = Label.new()
		var storyLabel = Label.new()
		
		hBox.alignment = BoxContainer.ALIGNMENT_CENTER
		nameLabel.text = get_ending_name_and_story_and_image(endings)["name"]
		storyLabel.text = get_ending_name_and_story_and_image(endings)["story"]
		
		#hBox.add_child(textureRect)
		hBox.add_child(nameLabel)
		
		$"ScrollContainer/Endings List".add_child(hBox)
		
#		show image and the text on the next line


func _on_to_title_pressed():
	Audio.SFX_stream.play(Audio.TRACK_ALIAS.Click)
	get_tree().change_scene_to_file("res://Scenes/Title/title.tscn")
