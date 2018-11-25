extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
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
	if overlaps_body($"/root/World/respawnpoint/player"):
		if (start == 2):
			if $"/root/World/respawnpoint/player".dash == true:
				$"/root/World/respawnpoint/player".velocity.y +=200
			else:
				$"/root/World/respawnpoint/player".velocity.y = BOUNCE_HEIGHT
			$"/root/World/respawnpoint/player".already_dashed = false
			
			
		else:
			start+=1
	pass