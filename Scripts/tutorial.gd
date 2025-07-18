extends Node2D

@onready var anim = $anim

func _ready() -> void:
	$HintList.anim.play("SlideUp")
