extends StaticBody2D

var RAND = RandomNumberGenerator.new();
var OPEN = preload('res://assets/chest_open.png');
var OPENED = false;
var TYPE = null;
var POWERUPS = [{
	'name': 'add_ball',
	'message': '+1 Ball'
}, {
	'name': 'powerup',
	'message': 'Damage +'
}, {
	'name': 'points',
	'message': '+Points'
}];

func _ready() -> void:
	TYPE = _random_type();

func _open_chest():
	OPENED = true;
	$sprite.texture = OPEN;
	
func _random_type():
	RAND.randomize();
	var rand = RAND.randi_range(0, POWERUPS.size() - 1);
	return POWERUPS[rand];
	
func _apply_chest():
	match TYPE.name:
		'add_ball':
			global.BALL_AMOUNT += 1;
		'powerup':
			print('power');
		'points':
			global.SCORE += 100;
