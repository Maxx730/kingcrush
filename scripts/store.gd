extends Node2D

var SCROLLING = false;
var SCROLLVIEW = null;

var list_item = preload('res://scenes/ui/list_item.tscn');

func _ready():
	SCROLLVIEW = get_node('ui/margin/contain/MarginContainer/scroll');
	
	for projectile in global.UNLOCKS.PROJECTILES:
		var item = list_item.instance();
		SCROLLVIEW.get_node('contain').add_child(item);
		item.NAME.text = projectile.name;
		item.PRICE.text = '$' + String(projectile.price);
		item.COLOR.modulate = Color(projectile.value[0], projectile.value[1], projectile.value[2], projectile.value[3]);
	
func _process(delta: float) -> void:
	if SCROLLING:
		print('scrolling');

func _on_back_pressed():
	get_tree().change_scene('res://scenes/main_menu.tscn');
