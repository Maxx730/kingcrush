extends Node2D

func _ready() -> void:
	global.BALL_AMOUNT = 3;
	global.SCORE = 0;
	
	var data = global._load_data();
	print(data)

func _on_play_game_pressed() -> void:
	get_tree().change_scene('res://scenes/gameplay.tscn');


func _on_store_button_pressed():
	get_tree().change_scene('res://scenes/store.tscn');
