extends Node2D

export var OFFSET = 100;
export (float) var SPEED = 1;
var START_POS = null;
var GOING_UP = true;

func _ready():
	START_POS = position;

func _process(delta):
	if GOING_UP:
		position = Vector2(position.x, position.y - 1 / SPEED);
		
		if position.y < START_POS.y - OFFSET:
			GOING_UP = false;
	else:
		position = Vector2(position.x, position.y + 1 / SPEED);
		
		if position.y > START_POS.y + OFFSET:
			GOING_UP = true;
	
