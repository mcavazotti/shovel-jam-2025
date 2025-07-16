extends Control


@onready var anim = $anim
@onready var image = $TextureRect

func _ready() -> void:
	var screen_size = DisplayServer.screen_get_size()
	anim.play("IntermediateEndings")	
	image.custom_minimum_size = Vector2(screen_size.x - 200, screen_size.y - 112.5)
	

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "IntermediateEndings":
		anim.play("FinalEnding")
