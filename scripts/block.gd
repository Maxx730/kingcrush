extends StaticBody2D

export var HITPOINTS = 5;

var HITPOINT_LABEL = null;
var RAND = RandomNumberGenerator.new();

func _ready() -> void:
	RAND.randomize();
	HITPOINT_LABEL = get_node("health");
	HITPOINTS = RAND.randi_range(1, 10);
	HITPOINT_LABEL.text = String(HITPOINTS);
	
func _damage_block(value):
	if HITPOINTS - value > 0:
		HITPOINTS -= value;
		HITPOINT_LABEL.text = String(HITPOINTS);
	else:
		self.queue_free();
		
	get_parent().get_parent()._check_row();