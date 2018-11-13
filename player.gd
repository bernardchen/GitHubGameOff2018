extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -550
const DASH_TIME = 1

var motion = Vector2()
var dashing = false
var dir = 1
var dash_acc = 0

func _physics_process(delta):
	if dashing:
		dash_acc += delta
		$Sprite.play("Dash")
		motion.y = 0
		motion.x = dir * 100 * SPEED
		if dash_acc >= DASH_TIME:
			dashing = false
			motion.x = 0
			motion.y = 0
			dash_acc = 0
		pass

	motion.y += GRAVITY
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.flip_h = false
		$Sprite.play("Run")
		dir = 1
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("Run")
		dir = -1
	else:
		motion.x = 0
		$Sprite.play("Idle")
	
	if Input.is_action_just_pressed("ui_select"):
		dashing = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else:
		$Sprite.play("Jump")
		
	motion = move_and_slide(motion, UP)
	pass