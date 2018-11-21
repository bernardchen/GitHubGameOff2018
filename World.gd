extends Node

onready var world1 = get_node("world1")
onready var world1_outline = get_node("world1_outline")
onready var world2 = get_node("world2")
onready var world2_outline = get_node("world2_outline")
onready var player = get_node("respawnpoint/player")
var currWorld = 1 #1 is world1, 2 is world2

func to_world1():
	world2.hide()
	world1.show()
	world2_outline.show()
	world1_outline.hide()
	player.set_collision_mask_bit(1, false)
	player.set_collision_layer_bit(1, false)
	player.set_collision_mask_bit(0, true)
	player.set_collision_layer_bit(0, true)

func to_world2():
	world1.hide()
	world2.show()
	world1_outline.show()
	world2_outline.hide()
	player.set_collision_mask_bit(0, false)
	player.set_collision_layer_bit(0, false)
	player.set_collision_mask_bit(1, true)
	player.set_collision_layer_bit(1, true)

func _ready():
	to_world1()

func switch():
	if currWorld == 1:
		to_world2()
		currWorld = 2
	else:
		to_world1()
		currWorld = 1

func can_switch():
	var ret
	if currWorld == 1:
		to_world2()
		ret = not player.is_on_wall()
		to_world1()
	else:
		to_world1()
		ret = not player.is_on_wall()
		to_world2()
	return ret

func _process(delta):
	if Input.is_action_just_pressed("ui_switch"):
		switch()
	pass
