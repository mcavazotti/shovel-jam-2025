extends Node

@onready var itemData = {}	#all items stored here
@onready var data_file_path = "res://Items/exemples of json item.json"

#var image: String #path to sprite
#var id: int 
#var tags = [] #multiples and effects
#var category: int 
#var shape = [] #append Lists
#var description: String #summary of the item
#var image : String #path to the image

func _ready():
	itemData = loadItems(data_file_path)
	

func loadItems(JsonPath):
	if FileAccess.file_exists(JsonPath):
		
		var dataFile = FileAccess.open(JsonPath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Array:
			return parsedResult
		else:
			print("Error reading file!")
			
	else:
		print("File doesn't exist!")
	
