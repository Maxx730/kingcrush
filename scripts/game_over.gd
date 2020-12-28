extends Node2D

var GAMEPLAY = preload('res://scenes/gameplay.tscn');

func _ready() -> void:
	var coins_gained = floor(global.SCORE / 100);
	get_node('ui/margin/container/score').text = String(global.SCORE);
	
	var data = global._load_data();
	data.COINS += coins_gained;
	global._save_data(data);

func _on_retry_pressed() -> void:
	global.BALL_AMOUNT = 3;
	get_tree().change_scene('res://scenes/gameplay.tscn');


func _on_main_menu_pressed() -> void:
	get_tree().change_scene('res://scenes/main_menu.tscn');


func _on_continue_pressed():
	get_tree().change_scene("res://scenes/full_ad.tscn");
