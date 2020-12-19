extends Label

export var SPEED = 50;
export var TIMEOUT = 1;

var PARENT = null;
var TIME = 0;

func _ready() -> void:
	PARENT = get_parent();

func _process(delta: float) -> void:
	if TIME < TIMEOUT:
		if PARENT:
			PARENT.global_position = Vector2(PARENT.global_position.x,PARENT.global_position.y - SPEED * delta);
			TIME += delta;
	else:
		PARENT.queue_free();
