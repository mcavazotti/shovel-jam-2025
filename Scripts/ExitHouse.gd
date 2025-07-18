extends Area2D

@onready var backpack = $"../BackpackController"
var categories
var ids
var tags

func _ready() -> void:
	backpack.connect("ContentChange", Callable(self, "_on_BackpackContentChange"))


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		getItems()
		get_tree().change_scene_to_file("res://Scenes/gameOverCutscenes.tscn")


func getItems():
	var items = []
	
	if ids:
		for index in range(ids.size()):
			items.append({
				"Id": ids[index],
				"Category": categories[index],
				"Tags": tags[index]			
			})
	
	FinalEndingLoad.itemsBackpack = items


func _on_BackpackContentChange(items:Array):
	ids = (items.map(func(i): return i.Id))
	categories = (items.map(func(i): return i.Category))
	tags = (items.map(func(i): return i.Tags))
	
	
