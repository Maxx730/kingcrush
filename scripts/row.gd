extends Node2D

var POINTS = [];
var ADD_BALL = preload('res://scenes/chest.tscn');
var SPIKE = preload('res://scenes/spike_trap.tscn');
var BLOCKS = [{
	'weight': 1,
	'min': 0,
	'max': 10,
	'object': preload('res://scenes/crate.tscn'),
	'name': 'crade',
	'sound': null
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
}, {
	'weight': 1,
	'min': 30,
	'max': -1,
	'object': preload('res://scenes/armor_stand.tscn')
}, {
	'weight': 1,
	'min': 30,
	'max': -1,
	'object': preload('res://scenes/enemies/spider.tscn')
}, {
	'weight': 1,
	'min': 35,
	'max': -1,
	'object': preload('res://scenes/enemies/bat.tscn')
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
	if rand > 0.55 and !HAS_CHEST and !HAS_SPIKE:
		#50/50 chance of spawning a chest or spike aftwards
		if rand < 0.75:
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
	var pool = [];
	
	#Create the pool of potential blocks	
	for i in range(BLOCKS.size()):
		# -1 indicates that the block will never stop spawning regardless of the wave.
		if (BLOCKS[i].max > global.WAVE or BLOCKS[i].max == -1) and BLOCKS[i].min < global.WAVE:
			pool.append(BLOCKS[i]);
	
	RAND.randomize();
	var rand = RAND.randi_range(0, pool.size());
	var block = pool[rand - 1].object.instance();
	POINTS.append(_child);
	_child.add_child(block);
