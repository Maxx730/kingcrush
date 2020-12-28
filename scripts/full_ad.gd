extends Node2D

func _ready():
	$ad.load_rewarded_video();
	$ad.hide_banner();

func _on_ad_interstitial_loaded():
	$ad.show_interstitial();

func _on_ad_interstitial_closed():
	print('closing add screen');


func _on_ad_rewarded_video_loaded():
	$ad.show_rewarded_video();


func _on_ad_rewarded_video_closed():
	$ad.queue_free();


func _on_ad_rewarded(currency, ammount):
	get_tree().change_scene("res://scenes/gameplay.tscn");
