extends Node2D

var GAMEPLAY = preload('res://scenes/gameplay.tscn');
var SCORE = null;
var WINNINGS = null;

func _ready() -> void:
	var coins_gained = floor(global.SCORE / 100);
	SCORE = get_node('ui/margin/container/score');
	WINNINGS = get_node('ui/margin/container/HBoxContainer/winnings');
	
	WINNINGS.text = String(coins_gained);
	
	var data = global._load_data();
	data.COINS += coins_gained;
	global._save_data(data);

func _on_retry_pressed() -> void:
	global._reset_globals();
	get_tree().change_scene('res://scenes/gameplay.tscn');


func _on_main_menu_pressed() -> void:
	global._reset_globals();
	get_tree().change_scene('res://scenes/main_menu.tscn');


func _on_continue_pressed():
	get_tree().change_scene("res://scenes/full_ad.tscn");

func _process(delta: float) -> void:
	if int(SCORE.text) < global.SCORE:
		SCORE.text = String(int(SCORE.text) + 1);
