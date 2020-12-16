extends Node2D

var LIGHT = null;

func _ready() -> void:
	LIGHT = get_node("light");