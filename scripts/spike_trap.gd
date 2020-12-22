extends StaticBody2D

var HAS_ACTIVATED = false;

func _activate():
	HAS_ACTIVATED = true;
	$sprite/anim.stop();
	$sprite.frame = 0;