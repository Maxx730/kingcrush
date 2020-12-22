extends Node2D

var POINTS = [];
var BLOCK = preload('res://scenes/crate.tscn');
var POT = preload('res://scenes/pot.tscn');
var BARREL = preload('res://scenes/barrel.tscn');
var ADD_BALL = preload('res://scenes/chest.tscn');
var TABLE = preload('res://scenes/table.tscn');
var SPIKE = preload('res://scenes/spike_trap.tscn');
var PLANT = preload('res://scenes/plant.tscn');
var RAND = RandomNumberGenerator.new();
var HAS_CHEST = false;
var HAS_SPIKE = false;

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
	
	if rand > 0.96 and !HAS_CHEST and !HAS_SPIKE:
		if rand > 0.88:
			POINTS.append(_child);
			var add_ball = ADD_BALL.instance();
			_child.add_child(add_ball);
			HAS_CHEST = true;
		else:
			POINTS.append(_child);
			var spike = SPIKE.instance();
			_child.add_child(spike);
			HAS_SPIKE = true;
	elif rand > 0.85:
		pass;
	else:
		_get_block(_child);
		
func _get_block(_child):
	RAND.randomize();
	var perc = RAND.randf_range(0, 1);
	
	if perc < 0.3:
		POINTS.append(_child);
		var table = TABLE.instance();
		_child.add_child(table);
	elif perc < 0.7 and perc > 0.6:
		POINTS.append(_child);
		var plant = PLANT.instance();
		_child.add_child(plant);
	elif perc < 0.6:
		POINTS.append(_child);
		var barrel = BARREL.instance();
		_child.add_child(barrel);
	else:
		POINTS.append(_child);
		var block = BLOCK.instance();
		_child.add_child(block);