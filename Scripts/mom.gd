extends CharacterBody2D

@export var speed: float = 300.0
@export var moving_bounce_speed: float = 5

func get_input():
	var input_direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	velocity = input_direction * speed
	if velocity.x < 0:
		$MomPlacehold.flip_h = false
	if velocity.x > 0:
		$MomPlacehold.flip_h = true
	
	if input_direction == Vector2(0,0):
		$MomPlacehold.material.set_shader_parameter("speed", 3.5)
		$Shadow.material.set_shader_parameter("speed", 3.5)
	else:
		$MomPlacehold.material.set_shader_parameter("speed", moving_bounce_speed)
		$Shadow.material.set_shader_parameter("speed", moving_bounce_speed)


func _physics_process(_delta):
	get_input()
	move_and_slide()
