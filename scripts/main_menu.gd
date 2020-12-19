extends Node2D


func _on_play_game_pressed() -> void:
	get_tree().change_scene('res://scenes/gameplay.tscn');
