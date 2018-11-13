extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500
const DASH_LEN = .15

var velocity = Vector2()
var dash = false
var already_dashed = false
var dash_cnt = 0
var dir = 1 #right is 1, left is -1

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
	
	if Input.is_action_just_pressed("ui_select") and not already_dashed:
		dash = true

func _physics_process(delta):
	velocity.y += GRAVITY
	if dash:
		dash_cnt += delta
		$Sprite.play("Dash")
		if dash_cnt < DASH_LEN:
			velocity.y = 0
			velocity.x = dir * 700
		else: 
			dash = false
			velocity = Vector2(0, 0)
			dash_cnt = 0
			already_dashed = true
	else:
		calc_movement()
	velocity = move_and_slide(velocity, UP)
	pass