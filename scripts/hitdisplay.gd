extends Node2D;

func _ready() -> void:
	var anim = get_node('hitdisplay/animate');
	anim.interpolate_property(self, "position",
		Vector2(0, 0), Vector2(0, -100), 5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	anim.start();
	print(global_position);