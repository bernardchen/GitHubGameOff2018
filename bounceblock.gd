extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var start = 0
const BOUNCE_HEIGHT = -650

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.connect("body_entered", self, "_on_body_entered")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_body_entered(body):
	#if (start == 1):
	$"/root/World/respawnpoint/player".velocity.y = BOUNCE_HEIGHT
	$"/root/World/respawnpoint/player".already_dashed = false
	#else:
	#	start+=1