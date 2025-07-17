extends Node2D

var target: Node2D

func _ready():
	target = $"../../ExitHouse/Tracker"
	print(target)

func _process(delta):
	if target and global_position.distance_to(target.global_position) > 1:
		look_at(target.global_position)
