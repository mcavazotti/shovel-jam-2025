extends CanvasLayer


@onready var anim = $"../anim"
@onready var backpack = $"../BackpackController"
@onready var node = $".."
var isHidden : bool = false
var labels: Array


func _ready() -> void:
	backpack.connect("ContentChange", Callable(self, "_on_BackpackContentChange"))
	labels.append($Panel/VBoxContainer/Label)
	labels.append($Panel/VBoxContainer/Label2)
	labels.append($Panel/VBoxContainer/Label3)
	labels.append($Panel/VBoxContainer/Label4)
	
func _on_BackpackContentChange(items:Array):
	$Panel/VBoxContainer/Label2.set_modulate("ffffff13")
	$Panel/VBoxContainer/Label3.set_modulate("ffffff13")
	if items.size() >= 1:
		$Panel/VBoxContainer/Label4.set_modulate("ffffff13")
		
	var unlockDoor = verifyLabels()
	
	if unlockDoor:
		node.unlockDoor()
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("HideShowHintList"):
		$Panel/VBoxContainer/Label.set_modulate("ffffff13")
		if isHidden:
			Down()
		else:
			Up()
		isHidden = !isHidden
		
		var unlockDoor = verifyLabels()
		if unlockDoor:
			node.unlockDoor()

func Down():
	anim.play("ListDown")
	
func Up():
	anim.play("ListUp")

func verifyLabels():
	var unlockDoor = []
	for label in labels:
		unlockDoor.append(label.modulate == Color8(255, 255, 255, 0x13))
	
	if unlockDoor.has(false):
		return false
	else:
		return true
