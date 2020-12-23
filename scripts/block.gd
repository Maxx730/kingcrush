extends StaticBody2D

export var HITPOINTS = 5;

var HITPOINT_LABEL = null;
var RAND = RandomNumberGenerator.new();
var ANIM = null;
var GAMEPLAY = null;
var DESTROYED_ANIM = preload("res://scenes/block_destroyed.tscn");

func _ready() -> void:
	GAMEPLAY = get_parent().get_parent().get_parent();
	RAND.randomize();
	HITPOINT_LABEL = get_node("health");
	HITPOINTS = RAND.randi_range(1, floor(.5 * GAMEPLAY.WAVE + 1));
	HITPOINT_LABEL.text = String(HITPOINTS);
	if has_node('sprite/anim'):
		ANIM = get_node('sprite/anim');
		ANIM.stop();
		ANIM.connect('animation_finished', self, '_stop_shake');
	
func _damage_block(value):
	if HITPOINTS - value > 0:
		HITPOINTS -= value;
		HITPOINT_LABEL.text = String(HITPOINTS);
		
		if ANIM:
			ANIM.play('shake');
	else:
		var damage_end = DESTROYED_ANIM.instance();
		damage_end.global_position = position;
		get_parent().add_child(damage_end);
		self.queue_free();
		
	get_parent().get_parent()._check_row();
	
func _stop_shake():
	ANIM.stop();