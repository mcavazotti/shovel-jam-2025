extends Control

@onready var unlocked = SaveNLoad.endingUnlocked
@onready var sizeUnlocked = unlocked.size()
@onready var total = FinalEndingLoad.endingData.size()

func _ready():
	Audio.Play(Audio.TRACK_ALIAS.Results)
	
	var endingCount = Label.new()
	var hBoxEndingCount = HBoxContainer.new()
	
	hBoxEndingCount.alignment = BoxContainer.ALIGNMENT_CENTER
	endingCount.text = "%s/%s" % [str(sizeUnlocked), str(total)]
	
	hBoxEndingCount.add_child(endingCount)
	$"ScrollContainer/Achievements List".add_child(hBoxEndingCount)
	
	for endings in unlocked:
		var hBox = HBoxContainer.new()
		var textureRect = TextureRect.new()
		var label = Label.new()
		
		hBox.alignment = BoxContainer.ALIGNMENT_CENTER
		label.text = "SaveNLoad.endingUnlocked"
		textureRect.texture = preload("res://Assets/Art/Hana Stare.png") # The appropriate image
		
		hBox.add_child(textureRect)
		hBox.add_child(label)
		
		$"ScrollContainer/Achievements List".add_child(hBox)
		
#		show image and the text on the next line


func _on_to_title_pressed():
	get_tree().change_scene_to_file("res://Scenes/Title/title.tscn")
