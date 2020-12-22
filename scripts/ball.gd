extends KinematicBody2D

export var SPEED = 600;

var VELOCITY = Vector2(0, -SPEED);
var DIR = Vector2(0, -1);
var GAMEPLAY = null;
var TRAIL = null;
var IMPACT = preload("res://scenes/fast_impact.tscn");
var MESSAGE = preload("res://scenes/message.tscn");
var HIT_INDI = preload("res://scenes/hit.tscn");

func _ready() -> void:
	TRAIL = $trail;
	TRAIL.set_as_toplevel(true);

func _start(dir, pos, gameplay):
	rotation = dir;
	position = pos;
	VELOCITY = Vector2(SPEED, 0).rotated(rotation);
	GAMEPLAY = gameplay;

func _process(delta: float) -> void:
	if TRAIL.points.size() > 5:
		TRAIL.remove_point(0);
	else:	
		TRAIL.add_point(global_position);
	var collision = move_and_collide(VELOCITY * delta);
	
	if collision:
		if collision.collider.is_in_group('block'):
			if collision.collider.has_method('_damage_block'):
				collision.collider._damage_block(global.POWER);
				GAMEPLAY._check_active();
				GAMEPLAY._add_points(1);
				$hit.play();
				var hit = HIT_INDI.instance();
				hit.position = collision.position;
				get_parent().add_child(hit);
		elif collision.collider.is_in_group('chest'):
			var chest = collision.collider;
			
			if !chest.OPENED:
				GAMEPLAY._add_ball(1);
				var mes = MESSAGE.instance();
				mes.global_position = chest.global_position;
				mes.global_position.x -= 30;
				get_parent().add_child(mes);
				
			chest._open_chest();
		elif collision.collider.is_in_group('trap'):
			if !collision.collider.HAS_ACTIVATED:
				collision.collider._activate();
				if global.BALL_AMOUNT > 1:
					GAMEPLAY._add_ball(-1);
			
		var impact = IMPACT.instance();
		impact.global_position = collision.position;
		get_parent().add_child(impact);

		VELOCITY = VELOCITY.bounce(collision.normal);

		