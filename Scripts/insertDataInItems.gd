extends Node2D


@onready var children = $".".get_children()
var copiedItemData
var roullete = []

func _ready():
	randomize()
	copiedItemData = ItemDataLoad.getCopiedData()
	for item in copiedItemData:
		roullete.append(item["id"])
		
	for child in children:
		if child is Item:
			connectItemData(child)
			
	#print(ItemDataLoad.itemData) Verify if ItemData is NOT modified
			

func connectItemData(itemInHouse): #Put randomItem data inside Item
	var randomIndex = randi() % roullete.size()
	var randomId = roullete[randomIndex]
	#print(roullete)
	for item in copiedItemData:
		if item["id"] == randomId:
			itemInHouse.id = item["id"]
			itemInHouse.name = item["name"]
			itemInHouse.tags = item["tags"]
			itemInHouse.category = item["category"]
			itemInHouse.description = item["description"]
			itemInHouse.image = item["image"]
			itemInHouse.shape = item["shape"]
			
			#if we need to config something with button inside the item.
			#var button = itemInHouse.get_children()[0] #button always on first index
		
			
			copiedItemData.erase(item)
			roullete.erase(randomId)
			
			#print(roullete)

#print(copiedItemData) Verify if CopiedItemData is erasing properly
