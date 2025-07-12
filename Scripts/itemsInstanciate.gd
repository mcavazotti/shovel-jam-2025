extends Node

@onready var itemData = {}	
@onready var data_file_path = "res://Items/exmples of json item.json"

#var image: String #path to sprite
#var id: int 
#var tag = [] #multiples and effects
#var category: int 
#var shape = [] #append Lists
#var description: String #summary of the item
#var image : String

func _ready():
	itemData = instanciateItem(data_file_path)
	print(itemData)

func instanciateItem(itemJsonPath):
	if FileAccess.file_exists(itemJsonPath):
		
		var dataFile = FileAccess.open(itemJsonPath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("Error reading file!")
			
	else:
		print("File doesn't exist!")
	
