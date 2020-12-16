extends Node2D

export var BALL_AMOUNT = 5;

var DRAG = null;
var IS_DOWN = false;
var DOWN_POINT = null;
var COLLISION_POINTS = PoolVector2Array();
var START_POINT = null;
var HAS_SHOT = false;
var SHOT_SPEED = 0.05;
var LAST_SHOT = 0;
var FIRED = 0;
var ACTIVE = 0;
var LAST_MOUSE = Vector2();
var SCREEN_SIZE = null;
var DESPAWN = null;
var DANGER_LABEL = null;
var DANGER_TIME = 1;
var DANGER_LAST = 0;
var BALL_LABEL = null;
var LEVEL_BETWEEN_WAIT = 2;
var LEVEL_BETWEEN_LAST = 0;
var INITIAL_ROW_POS = Vector2(179.4, 115.637);
var WAVE = 1;
var WAVE_LABEL = null;
var POINTS = 0;
var POINTS_LABEL = null;

var BALL = preload('res://scenes/ball.tscn');
var ROW = preload('res://scenes/row.tscn');

func _draw():
	draw_rect(Rect2(10, 70, 340, 595), Color.black, true)

func _ready() -> void:
	DRAG = $dragger;
	SCREEN_SIZE = get_viewport().get_visible_rect().size;
	START_POINT = Vector2(SCREEN_SIZE.x / 2, SCREEN_SIZE.y - 100);
	DANGER_LABEL = get_node('walls/danger_zone/danger/danger_label');
	BALL_LABEL = get_node("ui/top_container/hbox/ball_number");
	WAVE_LABEL = get_node("ui/top_container/hbox/wave_label");
	POINTS_LABEL = get_node("ui/top_container/hbox/points");
	
	BALL_LABEL.text = ' X ' + String(BALL_AMOUNT);
	
func _process(delta: float) -> void:
	if LEVEL_BETWEEN_LAST > LEVEL_BETWEEN_WAIT:
		if LAST_SHOT > SHOT_SPEED and HAS_SHOT:
			if FIRED < BALL_AMOUNT:
				FIRED += 1;
				LAST_SHOT = 0;
				
				var ball = BALL.instance();
				ball._start(_get_mouse_dir().angle(), START_POINT, self);
				add_child(ball);
				ACTIVE += 1;
			else:
				FIRED = 0;
				HAS_SHOT = false;
				LAST_SHOT = 0;
		else:
			LAST_SHOT += delta;
	else:
		LEVEL_BETWEEN_LAST += delta;
		
	if DANGER_LAST > DANGER_TIME:
		_toggle_danger();
		DANGER_LAST = 0;
	else:
		DANGER_LAST += delta;
		
func _input(event: InputEvent) -> void:
	if LEVEL_BETWEEN_LAST > LEVEL_BETWEEN_WAIT:
		if event is InputEventScreenTouch and DRAG:
			if !event.pressed and ACTIVE == 0:
				HAS_SHOT = true;
				DRAG.points = PoolVector2Array();
				LAST_SHOT = 0;
				
		elif event is InputEventScreenDrag and DRAG and !HAS_SHOT and ACTIVE == 0:
			COLLISION_POINTS = PoolVector2Array();
			DRAG.points = PoolVector2Array();
			var space = get_world_2d().direct_space_state;
			LAST_MOUSE = get_global_mouse_position();
			var dir = _get_mouse_dir();
			var collision = space.intersect_ray(START_POINT,dir * 1000);
			
			if collision:
				COLLISION_POINTS.append(collision.position);
				
				var angle = dir.angle_to(collision.normal);
				var next = collision.normal.rotated(angle) * -1000 + collision.position;
				var next_collision = space.intersect_ray(collision.position, next, [collision.collider]);
	
				if next_collision:
					COLLISION_POINTS.append(next_collision.position);
				
				_draw_path();
				update();
			
func _draw_path():
	DRAG.add_point(START_POINT);
	
	for point in COLLISION_POINTS:
		DRAG.add_point(point);
		
func _get_mouse_dir():
	return LAST_MOUSE - START_POINT;

func _on_wall_bottom_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group('ball'):
		ACTIVE -= 1;
		body.queue_free();
		_check_active();

func _check_rows():
	for _row in get_tree().get_nodes_in_group('row'):
		_row._check_row();
		
func _toggle_danger():
	if DANGER_LABEL:
		var color = DANGER_LABEL.get('custom_colors/font_color');
		if color.a < 1:
			DANGER_LABEL.set('custom_colors/font_color', Color(1, 0, 0, 1));
		else:
			DANGER_LABEL.set('custom_colors/font_color', Color(1, 0, 0, .27));
			
func _move_rows():
	for _row in get_tree().get_nodes_in_group('row'):
		_row.position = Vector2(_row.position.x, _row.position.y + 50);
		
func _check_active():
	if ACTIVE == 0:
		_check_rows();
		_move_rows();
		_create_row();
		LEVEL_BETWEEN_LAST = 0;

func _create_row():
	if ROW:
		var row = ROW.instance();
		row.position = INITIAL_ROW_POS;
		add_child(row);
		WAVE += 1;
		WAVE_LABEL.text = String(WAVE);
		
func _add_points(value):
	POINTS += value;
	POINTS_LABEL.text = String(POINTS);
	
func _add_ball(value):
	BALL_AMOUNT += value;
	BALL_LABEL.text = ' X ' + String(BALL_AMOUNT);