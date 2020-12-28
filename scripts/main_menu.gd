extends Node2D

var AD = null;

func _ready() -> void:
	global.BALL_AMOUNT = 3;
	global.SCORE = 0;
	
	var data = global._load_data();
	#get_node('ui/margin/container/__/VBoxContainer/HBoxContainer/coin_count').text = ' X ' + String(data.COINS);
	AD = get_node("ui/margin/container/ad");
	AD.load_banner();

func _on_play_game_pressed() -> void:
	get_tree().change_scene('res://scenes/gameplay.tscn');


func _on_store_button_pressed():
	get_tree().change_scene('res://scenes/full_ad.tscn');


func _on_ad_banner_loaded():
	pass;
