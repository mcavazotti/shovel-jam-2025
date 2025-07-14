extends Node2D


@onready var children = $".".get_children() #node where items are
var copiedItemData
var roullete = []
var i = 0


func _ready():
	randomize()
	copiedItemData = ItemDataLoad.getCopiedData()
	for item in copiedItemData:
		roullete.append(item["id"])
		
	for child in children:
		if child is Item:
			connectItemData(child)
			

func connectItemData(itemInHouse): #Put randomItem data inside Item
	var randomIndex = randi() % roullete.size()
	var randomId = roullete[randomIndex]
	for item in copiedItemData:
		if item["id"] == randomId:
			itemInHouse.id = item["id"]
			itemInHouse.name = item["name"]
			itemInHouse.tags = item["tags"]
			itemInHouse.category = item["category"]
			itemInHouse.description = item["description"]
			itemInHouse.shape = item["shape"]
			
			var button = itemInHouse.get_children()[0] #button always on first index
			#changeTextureItem(itemInHouse, item["image"], button)

			copiedItemData.erase(item)
			roullete.erase(randomId)


func changeTextureItem(item, texture, newButton):
	var newTexture = load(texture)
	item.texture = newTexture
	var item_size = newTexture.get_size()
	var item_position = item.global_position
	newButton.global_position = item_position - (item_size / 2)
	newButton.set_size(item_size)
