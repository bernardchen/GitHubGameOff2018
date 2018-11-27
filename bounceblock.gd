extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var player = $"/root/World/player"
var start = 0
const BOUNCE_HEIGHT = -650

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here
	if overlaps_body(player):
		if (start == 2):
			if player.dash == true:
				player.velocity.y +=200
			else:
				player.velocity.y = BOUNCE_HEIGHT
			player.already_dashed = false
			
			
		else:
			start+=1
	pass