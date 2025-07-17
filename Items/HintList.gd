extends CanvasLayer


@onready var anim = $AnimationPlayer
@onready var backpack = $"../BackpackController"

#the labels are names after the ENUM of Categories
func _ready() -> void:
	backpack.connect("ContentChange", Callable(self, "_on_BackpackContentChange"))


func _on_BackpackContentChange(items:Array):
	var categories = (items.map(func(i): return i.Category))
	updateList(categories)
		
	
func updateList(categories):
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
