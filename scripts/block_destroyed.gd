extends Sprite;

func _destroy():
	queue_free();

func _on_anim_animation_finished(anim_name: String) -> void:
	_destroy();
