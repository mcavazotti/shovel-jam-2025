extends CanvasLayer


@onready var anim = $AnimationPlayer
@onready var backpack = $"../BackpackController"
var categories
var ids
var tags

#the labels are names after the ENUM of Categories
func _ready() -> void:
	backpack.connect("ContentChange", Callable(self, "_on_BackpackContentChange"))


func _on_BackpackContentChange(items:Array):
	categories = (items.map(func(i): return i.Category))
	ids = (items.map(func(i): return i.Id))
	tags = (items.map(func(i): return i.Tags))
	
	updateList()
		
	
func updateList():
	for category in categories:
		match category:
			1000:
				$Panel/VBoxContainer/Food.set_modulate("ffffff13")
			2000:
				$Panel/VBoxContainer/Cloathing.set_modulate("ffffff13")
			3000:
				$Panel/VBoxContainer/Weapon.set_modulate("ffffff13")
			4000:
				$Panel/VBoxContainer/Misc.set_modulate("ffffff13")
			_:
				print("Unknown Category, something fucked up")
				
				
func getItems():
	var items = []
	if ids:
		for index in range(ids.size()):
			items.append({
				"Id": ids[index],
				"Category": categories[index],
				"Tags": tags[index]			
			})
		print("in getItems()", items)
	FinalEndingLoad.itemsBackpack = items
