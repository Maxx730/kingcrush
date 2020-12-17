extends Node2D

var GAMEPLAY = preload('res://scenes/gameplay.tscn');



func _on_retry_pressed() -> void:
	get_tree().change_scene('res://scenes/gameplay.tscn');
