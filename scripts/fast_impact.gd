extends Sprite

func _ready() -> void:
	$anim.connect('animation_finished', self, '_destroy');
	
func _destroy(anim):
	queue_free();