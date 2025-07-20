extends CanvasLayer



@onready var backpack = $"../BackpackController"
var isHidden : bool = false

#the labels are names after the ENUM of Categories
func _ready() -> void:
	$anim.play("ListDown")
	backpack.connect("ContentChange", Callable(self, "_on_BackpackContentChange"))


func _on_BackpackContentChange(items:Array):
	var categories = (items.map(func(i): return i.Category))
	updateList(categories)
		
	
func updateList(categories):
	for category in categories:
		match category:
			1000:
				$Panel/VBoxContainer/Food.set_modulate("11ff11")
			2000:
				$Panel/VBoxContainer/Cloathing.set_modulate("11ff11")
			3000:
				$Panel/VBoxContainer/Weapon.set_modulate("11ff11")
			4000:
				$Panel/VBoxContainer/Misc.set_modulate("11ff11")
			_:
				print("Unknown Category")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("HideShowHintList"):
		if isHidden:
			$anim.play("ListDown")
		else:
			$anim.play("ListUp")
		isHidden = !isHidden
