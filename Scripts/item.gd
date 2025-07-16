extends Sprite2D

class_name Item

@onready var label := $Label as Label
var dragging = false
var of = Vector2(0, 0)

var itemData = {}
var over_bag : bool
var bag : Area2D
	

func _process(_delta):
	if dragging:
		position = get_global_mouse_position() - of
		label.visible = true
	

func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
	if over_bag:
		bag.dataRecieved = itemData
	label.visible = false
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bagArea"):
		over_bag = true
		bag = area


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("bagArea"):
		over_bag = false


func isVisible(element, value) -> void:
	element.visible = value



func _on_area_2d_mouse_entered() -> void:
	print("aaaaa")



func _on_button_mouse_entered() -> void:
	print("bbbb")
