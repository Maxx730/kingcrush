extends Node2D

var POINTS = [];
var BLOCK = preload('res://scenes/block.tscn');
var ADD_BALL = preload('res://scenes/add_ball.tscn');
var RAND = RandomNumberGenerator.new();

func _ready() -> void:
	for _child in get_children():
		_random_type(_child);
		
func _check_row():
	var _row_done = true;
	for _point in POINTS:
		if _point.get_child_count() > 0:
			_row_done = false;
			
func _random_type(_child):
	RAND.randomize();
	var rand = RAND.randf_range(0, 1);
	
	if rand > 0.9:
		POINTS.append(_child);
		var add_ball = ADD_BALL.instance();
		_child.add_child(add_ball);
	elif rand > 0.85:
		pass;
	else:
		POINTS.append(_child);
		var block = BLOCK.instance();
		_child.add_child(block);