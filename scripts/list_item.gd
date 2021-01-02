extends MarginContainer;

var store = null;

var NAME = null;
var PRICE = null;
var COLOR = null;

func _ready():
	store = get_tree().get_nodes_in_group('store');
	
	NAME = get_node('margin/HBoxContainer/HBoxContainer/VBoxContainer/name_label');
	PRICE = get_node('margin/HBoxContainer/HBoxContainer/VBoxContainer/price_label');
	COLOR = get_node('margin/HBoxContainer/HBoxContainer/sprite');

func _on_drag_button_button_down() -> void:
	if store.size() > 0:
		store[0].SCROLLING = true;


func _on_drag_button_button_up() -> void:
	if store.size() > 0:
		store[0].SCROLLING = false;
