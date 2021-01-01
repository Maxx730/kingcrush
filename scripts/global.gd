extends Node;

var DATA_PATH ='user://data.json';
var INIT = {
	"COINS": 0
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
