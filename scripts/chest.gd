extends StaticBody2D

var OPEN = preload('res://assets/chest_open.png');
var OPENED = false;

func _open_chest():
	OPENED = true;
	$sprite.texture = OPEN;