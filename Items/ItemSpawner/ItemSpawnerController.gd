extends Node2D


@onready var itemSpawners = get_tree().get_nodes_in_group("ItemSpawner") #node where items are
@onready var parent = get_parent()

const HouseItem = preload("res://Items/HouseItem/HouseItem.tscn")
const ItemSpawner = preload("res://Items/ItemSpawner/ItemSpawner.cs")

var items



func _ready():
	randomize()
	items = ItemDataLoad.getItems()
	print(itemSpawners)
	for child in itemSpawners:
		createItem(child as ItemSpawner)


func createItem(spawner:ItemSpawner): #Put randomItem data inside Item
	var validIds = items.keys().filter(func(i): return int(i) in spawner.IdsToAccept)
	print(spawner.IdsToAccept)
	print(validIds)

	if validIds.size() == 0:
		return
	
	var idx = 0
	if validIds.size() > 1:
		idx = randi_range(0, validIds.size() -1)

	var itemId = validIds[idx]

	var itemData = items[itemId]

	var pos = spawner.global_position
	var itemNode = HouseItem.instantiate()
	var stringData = JSON.stringify(itemData)
	itemNode.global_position = pos
	itemNode.name = itemData["name"]
	parent.add_child.call_deferred(itemNode)
	itemNode.SetData(stringData)
			
	items.erase(itemId)
