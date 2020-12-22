extends Node2D

var GAMEPLAY = preload('res://scenes/gameplay.tscn');

func _ready() -> void:
	get_node('ui/margin/container/score').text = String(global.SCORE);

func _on_retry_pressed() -> void:
	get_tree().change_scene('res://scenes/gameplay.tscn');


func _on_main_menu_pressed() -> void:
	get_tree().change_scene('res://scenes/main_menu.tscn');
