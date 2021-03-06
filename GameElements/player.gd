extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500
const DASH_LEN = .27
const WALL_JUMP_LEN = .35
const WALL_JUMP_LIM = 1.5
const BOUNCE_HEIGHT = -700

var velocity = Vector2()
var wall_jump
var wall_jump_cnt = 0
var wall_jump_lim_cnt = WALL_JUMP_LIM + 1
var last_wall_jump = 1
var dash = false
var already_dashed = false
var dash_cnt = 0
var dir = 1 #right is 1, left is -1
var bounce = false

onready var start_checkpoint = get_parent().get_node("start")
onready var curr_checkpoint = start_checkpoint

func _ready():
	z_index = 2
	set_global_position($"/root/World/start".get_global_position())

#RESPAWN
func _on_VisibilityNotifier2D_screen_exited():
	respawn()

func respawn():
	if curr_checkpoint == start_checkpoint:
		get_parent().to_world1()
	else:
		if curr_checkpoint.spawn_dimension == 1:
			get_parent().to_world1()
		else:
			get_parent().to_world2()
	set_global_position($"/root/World/start".get_global_position())
	velocity = Vector2(0, 0)
	dash = false
	wall_jump = false
	bounce = false
	already_dashed = false
	wall_jump_lim_cnt = WALL_JUMP_LIM + 1
	pass

func can_wall_jump():
	return wall_jump_lim_cnt > WALL_JUMP_LIM or dir != last_wall_jump

func calc_movement():
	if Input.is_action_pressed('ui_right'):
		velocity.x = SPEED
		$Sprite.flip_h = false
		$Sprite.play("Run")
		dir = 1
	elif Input.is_action_pressed('ui_left'):
		velocity.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("Run")
		dir = -1
	else:
		velocity.x = 0
		$Sprite.play("Idle")

	if is_on_floor():
		already_dashed = false
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_HEIGHT
	else:
		$Sprite.play("Jump")
		if is_on_wall():
			if velocity.y > 0:
				$Sprite.play("Wall")
				velocity.y = 100
			if Input.is_action_just_pressed("ui_up") and can_wall_jump():
				$Sprite.play("Jump")
				already_dashed = false
				wall_jump = true
				wall_jump_lim_cnt = 0
				last_wall_jump = dir
				dir = dir * -1
				velocity.y = -400
				if dir == 1:
					$Sprite.flip_h = false
				else:
					$Sprite.flip_h = true
	
	if Input.is_action_just_pressed("ui_select") and not already_dashed:
		dash = true
		velocity = Vector2(dir * 1000, 0)

func _physics_process(delta):
	if wall_jump_lim_cnt < (WALL_JUMP_LIM + 1):
		wall_jump_lim_cnt += delta
	velocity.y += GRAVITY
	if dash:
		if bounce:
			velocity.y = BOUNCE_HEIGHT
		else:
			velocity.y = 0
		dash_cnt += delta
		$Sprite.play("Dash")
		if dash_cnt < DASH_LEN:
			velocity *= .91
		else: 
			dash = false
			velocity = Vector2(0, 0)
			dash_cnt = 0
			already_dashed = true
	elif wall_jump:
		wall_jump_cnt += delta
		if wall_jump_cnt < WALL_JUMP_LEN:
			velocity.x = SPEED * dir
		else:
			wall_jump = false
			velocity = Vector2(0, 0)
			wall_jump_cnt = 0
	else:
		calc_movement()
	if bounce and not dash:
		velocity.y = BOUNCE_HEIGHT
		bounce = false
	velocity = move_and_slide(velocity, UP)
	pass