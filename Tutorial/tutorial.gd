extends Node2D

@onready var anim = $anim
var doorLocked: bool = true

func _ready() -> void:
	var ObjectivesList = $ObjectivesList
	ObjectivesList.Down()
	
	var resolution = get_viewport_rect().size
	

func _on_exit_house_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$ObjectivesList/Panel/VBoxContainer/Label5.set_modulate("ffffff13")
		SaveNLoad.tutorialCompleted = true
		SaveNLoad.save_game()
		

func unlockDoor():
	if doorLocked:
		$"Level Collision/DoorLock".queue_free()
		doorLocked = false
