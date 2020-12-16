extends KinematicBody2D

export var SPEED = 600;

var VELOCITY = Vector2(0, -SPEED);
var DIR = Vector2(0, -1);
var GAMEPLAY = null;
var TRAIL = null;

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
				collision.collider._damage_block(1);
				GAMEPLAY._check_active();
				GAMEPLAY._add_points(1);
		elif collision.collider.is_in_group('powerup'):
			if collision.collider.is_in_group('add_ball'):
				GAMEPLAY._add_ball(1);
				collision.collider.queue_free();

		VELOCITY = VELOCITY.bounce(collision.normal);

		