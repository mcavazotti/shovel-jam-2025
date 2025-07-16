extends Node2D


@onready var itemSpawners = get_tree().get_nodes_in_group("ItemSpawner") #node where items are
@onready var parent = get_parent()

const HouseItem = preload("res://Items/HouseItem/HouseItem.tscn")

var copiedItemData
var roulette = []
var categoryEnum = {
	1000: "Food",
	2000: "Cloathing",
	3000: "Weapon",
	4000: "Misc"
}


func _ready():
	randomize()
	copiedItemData = ItemDataLoad.getCopiedData()
	
	for item in copiedItemData:
		roulette.append(item["id"])
		
	for child in itemSpawners:
		createItem(child as Node2D)


func createItem(spawner:Node2D): #Put randomItem data inside Item
	var randomIndex = randi() % roulette.size()
	var randomId = roulette[randomIndex]

	for itemData in copiedItemData:
		if itemData["id"] == randomId:
			var pos = spawner.global_position
			var itemNode = HouseItem.instantiate()
			var stringData = JSON.stringify(itemData)
			itemNode.global_position = pos
			itemNode.name = itemData["name"]
			parent.add_child.call_deferred(itemNode)
			itemNode.SetData(stringData)
			
			copiedItemData.erase(itemData)
			roulette.erase(randomId)
			if copiedItemData.is_empty() or roulette.is_empty():
				break
