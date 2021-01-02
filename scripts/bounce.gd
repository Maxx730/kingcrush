extends Sprite


export var OFFSET = 10;
export (float) var SPEED = 1;

var GOING_UP = true;
var STARTING_POS = null;

func _ready() -> void:
	STARTING_POS = position;

func _process(delta: float) -> void:
	if GOING_UP:
		if position.y > STARTING_POS.y - OFFSET:
			position.y -= 1 * SPEED;
		else:
			GOING_UP = false;
	else:
		if position.y < STARTING_POS.y + OFFSET:
			position.y += 1 * SPEED;
		else:
			GOING_UP = true;
