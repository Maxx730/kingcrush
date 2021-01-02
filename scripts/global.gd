extends Node;

var DATA_PATH ='user://data.json';
var INIT = {
	"COINS": 0
};
var UNLOCKS = {
	"PROJECTILES": [
		{
			"name": "White",
			"price": 0,
			"unlocked":  false,
			"value": _get_color(255, 255, 255, 255)
		},
		{
			"name": "Red",
			"price": 0,
			"unlocked":  false,
			"value": _get_color(255, 0, 0, 255)
		},
		{
			"name": "Green",
			"price": 0,
			"unlocked":  false,
			"value": _get_color(0, 255, 0, 255)
		},
		{
			"name": "Blue",
			"price": 0,
			"unlocked":  false,
			"value": _get_color(0, 0, 255, 255)
		},
		{
			"name": "Orange",
			"price": 0,
			"unlocked":  false,
			"value": _get_color(235, 152, 52, 255)
		},
		{
			"name": "Purple",
			"price": 0,
			"unlocked":  false,
			"value": _get_color(195, 53, 235, 255)
		},
		{
			"name": "Pink",
			"price": 0,
			"unlocked":  false,
			"value": _get_color(235, 52, 174, 255)
		},
		{
			"name": "Lime",
			"price": 0,
			"unlocked":  false,
			"value": _get_color(140, 235, 52, 255)
		},
		{
			"name": "Cyan",
			"price": 0,
			"unlocked":  false,
			"value": _get_color(52, 235, 222, 255)
		}
	]
};
var BALL_AMOUNT= 3;
var SCORE = 0;
var POWER = 1;
var WAVE = 1;

func _load_data():
	if _data_exists(DATA_PATH):
		var file = File.new();
		file.open(DATA_PATH, File.READ);
		var data = parse_json(file.get_as_text());
		return data;
	else:
		_create_data();
		return INIT;

func _save_data(data):
	var file = File.new();
	file.open(DATA_PATH, File.WRITE);
	file.store_string(to_json(data));
	file.close();
	
func _data_exists(path):
	var file = File.new();
	return file.file_exists(path);
	
func _create_data():
	print('CREATING DATA FILE...');
	var file = File.new();
	file.open(DATA_PATH, File.WRITE);
	file.store_string(to_json(INIT));
	file.close();
	
func _reset_globals():
	BALL_AMOUNT = 3;
	WAVE = 1;
	SCORE = 0;

func _get_color(r, g, b, a):
	return Color(
		float (float (1.0 / 255.0) * r),
		float (float (1.0 / 255.0) * g),
		float (float (1.0 / 255.0) * b),
		float (float (1.0 / 255.0) * a)
	);
