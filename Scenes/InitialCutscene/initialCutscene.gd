extends Node2D

@onready var anim = $Control/AnimationPlayer
@onready var mom = $Control/Mom
@onready var camera = $Control/Path2D/PathFollow2D/camerafollower

var isPathFollowing = false
var dialogue = [
	["MOOOOOM! WE'RE GONNA BE LATE!", "... AH!", "Thank mom, you're the best!"],
	["Did you pack your backpack, dear?", "... I'll pack it up for you", "Hahaha just don't forget your head next time."]
]
var index = 0
							

func _ready() -> void:
	anim.play("coverFade")
	mom.camera.enabled = false
	camera.enabled = true
	isPathFollowing = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"coverFade":
			anim.play("Dialogue")
			

func dialogechangeSon():
	$Control/MomLabel.visible = false
	$SonText.play()
	$Control/SonLabel.visible = true
	$Control/SonLabel.text = dialogue[0][index]
	
	
func dialogechangeMom():
	$Control/SonLabel.visible = false
	$MomText.play()
	$Control/MomLabel.visible = true
	$Control/MomLabel.text = dialogue[1][index]
	index += 1
	
	
func toTitle():
	get_tree().change_scene_to_file("res://Scenes/Title/title.tscn")
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		anim.play("Skipped")
