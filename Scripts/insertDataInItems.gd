extends Node2D
const Item = preload("res://Scripts/item.gd")


@onready var itemSpawners = $"..".get_tree().get_nodes_in_group("itemSpawner") #node where items are
var copiedItemData
var roulette = []


func _ready():
	randomize()
	copiedItemData = ItemDataLoad.getCopiedData()
	
	for item in copiedItemData:
		roulette.append(item["id"])
		
	for child in itemSpawners:
		connectItemData(child)


func connectItemData(itemInHouse:Item): #Put randomItem data inside Item
	var randomIndex = randi() % roulette.size()
	var randomId = roulette[randomIndex]
	
	for item in copiedItemData:
		if item["id"] == randomId:
			itemInHouse.itemData = {
				"Id" : item["id"],
				"Name" : item["name"],
				"Tags" : item["tags"],
				"Category" : item["category"],
				"Description" : item["description"],
				"Shape" : item["shape"]
			}
			
			itemInHouse.name = item["name"]
			
			var button = itemInHouse.get_children()[0] #button always on first index	
			#changeTextureItem(itemInHouse, item["image"], button)
			changeTextureItem(itemInHouse, "res://Assets/Art/Hana Stare.png", button)

			var area2d = itemInHouse.get_children()[1] #buttons always on secound index
			changeArea2d(area2d, itemInHouse)
						
			area2d.set_collision_layer(2) #sets the collision layer to a itemInHouse
			itemInHouse.remove_from_group("itemSpawner")
			itemInHouse.add_to_group("Item")
			
			copiedItemData.erase(item)
			roulette.erase(randomId)
			if copiedItemData.is_empty() or roulette.is_empty():
				break


func changeTextureItem(item:Item, texture, newButton):
	var newTexture = load(texture)
	item.texture = newTexture
	var item_size = newTexture.get_size()
	var item_position = item.global_position
	newButton.global_position = item_position - (item_size / 2)
	newButton.set_size(item_size)


func changeArea2d(area, item:Item):
	area.global_position = item.global_position
	
	var shape = area.get_node("CollisionShape2D").shape
	var rect_size = item.get_rect().size
	shape.extents = rect_size / 2.0
