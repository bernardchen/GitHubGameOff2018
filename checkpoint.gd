extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

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
	if ($"/root/World/respt".get_global_position() != self.get_global_position()):
		$"/root/World/respt".set_global_position(self.get_global_position())