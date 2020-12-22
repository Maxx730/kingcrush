extends Node2D

func _ready() -> void:
	global.BALL_AMOUNT = 3;
	global.SCORE = 0;

func _on_play_game_pressed() -> void:
	get_tree().change_scene('res://scenes/gameplay.tscn');
