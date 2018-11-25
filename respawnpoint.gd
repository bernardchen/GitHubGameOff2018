extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	pass

func _on_VisibilityNotifier2D_screen_exited():
	$player.set_global_position($"/root/World/respt".get_global_position())
	$player.velocity = Vector2(0, 0)
	pass 