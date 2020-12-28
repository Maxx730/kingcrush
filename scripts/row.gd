extends Node2D

var POINTS = [];
var ADD_BALL = preload('res://scenes/chest.tscn');
var SPIKE = preload('res://scenes/spike_trap.tscn');
var BLOCKS = [{
	'weight': 1,
	'min': 0,
	'max': 10,
	'object': preload('res://scenes/crate.tscn')
},{
	'weight': 1,
	'min': 5,
	'max': 20,
	'object': preload('res://scenes/barrel.tscn')
},{
	'weight': 1,
	'min': 10,
	'max': 25,
	'object': preload('res://scenes/logs.tscn')
},{
	'weight': 1,
	'min': 20,
	'max': 35,
	'object': preload('res://scenes/sandbag.tscn')
}];
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
	
	# 4% chance of loading a chest or spike
	if rand > 0.96 and !HAS_CHEST and !HAS_SPIKE:
		#50/50 chance of spawning a chest or spike aftwards
		if rand < 0.98:
			POINTS.append(_child);
			var add_ball = ADD_BALL.instance();
			_child.add_child(add_ball);
			HAS_CHEST = true;
		else:
			#POINTS.append(_child);
			#var spike = SPIKE.instance();
			#_child.add_child(spike);
			#HAS_SPIKE = true;
			pass;
	#15% chance of not spawning anything at all
	elif rand > 0.85:
		pass;
	else:
		#85% chance of spawning a block
		_get_block(_child);
		
func _get_block(_child):
	var total_weight = 0;
	var pool = [];
	
	#Create the pool of potential blocks	
	for i in range(BLOCKS.size()):
		if BLOCKS[i].max > global.WAVE and BLOCKS[i].min < global.WAVE:
			pool.append(BLOCKS[i]);
	
	RAND.randomize();
	var rand = RAND.randi_range(0, pool.size());
	var block = pool[rand].object.instance();
	POINTS.append(_child);
	_child.add_child(block);
