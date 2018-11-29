extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var player = $"/root/World/player"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$vent.play("off")
	pass

func _physics_process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here
	if overlaps_body(player):
		player.bounce = true
		$vent.play("on")
	else:
		$vent.play("off")
	pass