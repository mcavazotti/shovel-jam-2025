extends Camera2D

@export var player: CharacterBody2D
@onready var size: Vector2i = get_viewport_rect().size

func _process(_delta):
	update_position()

func update_position():
	var current_cell: Vector2i = Vector2i(player.global_position) / size
	global_position = current_cell * size
