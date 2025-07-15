extends CharacterBody2D

@export var speed: float = 300.0

func get_input():
	var input_direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	velocity = input_direction * speed
	if velocity.x < 0:
		$MomPlacehold.flip_h = false
	if velocity.x > 0:
		$MomPlacehold.flip_h = true

func _physics_process(_delta):
	get_input()
	move_and_slide()
