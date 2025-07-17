extends CanvasLayer

const ItemData = preload("res://Items/ItemData.cs")

@onready var anim = $AnimationPlayer
@onready var backpack = $"../BackpackController"
var listagem = []

#the labels are names after the ENUM of Categories
func _ready() -> void:
	backpack.connect("BackpackContentChange", Callable(self, "_on_BackpackContentChange"))


func _on_BackpackContentChange(conteudo:ItemData):
	if listagem:
		var found = false
		for item in listagem:
			
			if item.Id == conteudo.Id:
				listagem.erase(item)
				found = true
				break
				
		if not found:
			listagem.append(conteudo)
	else:
		listagem.append(conteudo)
		
	updateList()
	
	
func updateList():
	for item in listagem:
		
		match item.Category:
			"Food":
				$Panel/VBoxContainer/Food.set_modulate("ffffff13")
			"Cloathing":
				$Panel/VBoxContainer/Cloathing.set_modulate("ffffff13")
			"Weapon":
				$Panel/VBoxContainer/Weapon.set_modulate("ffffff13")
			"Misc":
				$Panel/VBoxContainer/Misc.set_modulate("ffffff13")
			_:
				print("Unknown Category, something fucked up")
