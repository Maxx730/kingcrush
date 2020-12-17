extends Node2D

var LIGHT = null;
var EXPAND = true;
var RAND = RandomNumberGenerator.new();
var START_OFFSET = null;
var START_TIME = 0;

func _ready() -> void:
	LIGHT = get_node("light");
	RAND.randomize();
	START_OFFSET = RAND.randf_range(0, 2);
	
func _process(delta: float) -> void:
	if START_TIME > START_OFFSET:
		if EXPAND:
			if LIGHT.texture_scale < 2.5:
				LIGHT.texture_scale = LIGHT.texture_scale + .75 * delta;
			else:
				EXPAND = false;
		else:
			if LIGHT.texture_scale > 2:
				LIGHT.texture_scale = LIGHT.texture_scale - .75 * delta;
			else:
				EXPAND = true;
	else:
		START_TIME += delta;