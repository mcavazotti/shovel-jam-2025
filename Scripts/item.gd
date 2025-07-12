extends Node2D

class_name Item

var dragging = false
var of = Vector2(0, 0)

var image: String #path to image
var id: int 
var tags = [] #multiples and effects
var category: int 
var shape = [] #append Lists
var description: String #summary of the item

func _process(delta):
	if dragging:
		position = get_global_mouse_position() - of


func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
	
