extends Node

onready var world1 = get_node("world1")
onready var world2 = get_node("world2")
onready var player = get_node("player")

var faded_color = Color(1.0, 1.0, 1.0, 0.25)
var currWorld = 1 #1 is world1, 2 is world2

func to_world1():
	world2.modulate = faded_color
	world1.modulate = Color(1, 1, 1, 1)
	world2.z_index = 0
	world1.z_index = 1
	player.set_collision_mask_bit(1, false)
	player.set_collision_layer_bit(1, false)
	player.set_collision_mask_bit(0, true)
	player.set_collision_layer_bit(0, true)

func to_world2():
	world1.modulate = faded_color
	world2.modulate = Color(1, 1, 1, 1)
	world1.z_index = 0
	world2.z_index = 1
	player.set_collision_mask_bit(0, false)
	player.set_collision_layer_bit(0, false)
	player.set_collision_mask_bit(1, true)
	player.set_collision_layer_bit(1, true)

func _ready():
	global.stop_snowheart()
	if global.play_bgm:
		global.play_urban()
	to_world1()

func switch():
	if currWorld == 1:
		to_world2()
		currWorld = 2
	else:
		to_world1()
		currWorld = 1

func can_switch():
	var tilemap
	if currWorld == 1:
		tilemap = world2
	else:
		tilemap = world1
	var extents = get_node("player/CollisionShape2D").shape.extents
	if not tilemap == null:
		var map_pos = tilemap.world_to_map(player.global_position)
		var id0 = tilemap.get_cellv(map_pos)
		map_pos = tilemap.world_to_map(player.global_position + extents)
		var id1 = tilemap.get_cellv(map_pos)
		map_pos = tilemap.world_to_map(player.global_position - extents)
		var id2 = tilemap.get_cellv(map_pos)
		if id0 > -1 or id1 > -1 or id2 > -1:
			$Tween.interpolate_property($switch_warning/Label, "modulate", Color(1, 0, 0, 1), Color(1, 0, 0, 0), 1.3, 0, 0)
			$Tween.start()
			return false
		else:
			return true
	return false

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_switch"):
		if can_switch():
			switch()
	pass
