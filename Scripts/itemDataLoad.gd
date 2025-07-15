extends Node

@onready var itemData = {}	#all items stored here
@onready var dataFilePath = "res://Items/ItemsList.json"
var copiedData : Array

func _ready():
	itemData = loadItems(dataFilePath)
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
		print("Error reading items file!")	
			
	else:
		print("Items file doesn't exist!")
	
	
func copyData():
	copiedData.clear()
	copiedData = itemData.duplicate()
	
	
func getCopiedData():
	copyData()
	return copiedData
