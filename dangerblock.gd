extends Area2D
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.connect("body_entered", self, "_on_body_entered")
	pass

func _process(delta):
	pass

func _on_body_entered(body):
	$"/root/World/respawnpoint/player".set_global_position($"/root/World/respawnpoint".get_global_position())