extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const BOUNCE_HEIGHT = -650
var start = false

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
	if (start == true):
		$"/root/World/respawnpoint/player".velocity.y = BOUNCE_HEIGHT
	else:
		start = true