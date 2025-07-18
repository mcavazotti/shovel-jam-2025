extends Camera2D

@export var player: CharacterBody2D
@onready var size: Vector2i = get_viewport_rect().size

func _ready():
	update_position()

func _process(_delta):
	update_position()
	pass

func update_position():
	var current_cell: Vector2i = Vector2i(player.global_position) / size
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "global_position", Vector2(current_cell * size), 1.0)
