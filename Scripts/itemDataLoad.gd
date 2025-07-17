extends Node

@onready var dataFilePath = "res://Items/ItemsList.json"

var _itemsDict: Dictionary

func _ready():
	var itemData = loadItems(dataFilePath)
	_itemsDict = {}

	for  i in itemData:
		_itemsDict[int(i["id"])] = i
		
func loadItems(JsonPath):
	if FileAccess.file_exists(JsonPath):
		
		var dataFile = FileAccess.open(JsonPath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Array:
			return parsedResult
		printerr("Error reading items file!")	
			
	else:
		printerr("Items file doesn't exist!")
	
	

func getItems()-> Dictionary:
	return _itemsDict.duplicate()

