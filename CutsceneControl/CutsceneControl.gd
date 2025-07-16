extends Node2D


@onready var anim = $anim
var tween := create_tween()


func _ready() -> void:
	pass
	

func resetTween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
