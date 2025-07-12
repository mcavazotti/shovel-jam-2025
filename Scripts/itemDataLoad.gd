extends Node

@onready var itemData = {}	#all items stored here
@onready var data_file_path = "res://Items/exemples of json item.json"
var copiedData : Array

func _ready():
	itemData = loadItems(data_file_path)
#	for item in itemData:
#		for key in item:
#			var value = item[key]
#			print(key, value)
	copyData()
		
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
	
	
func copyData():
	copiedData.clear()
	copiedData = itemData.duplicate()
	
	
func getCopiedData():
	return copiedData
