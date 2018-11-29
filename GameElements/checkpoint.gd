extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var spawn_dimension = 1;
onready var start = $"/root/World/start"
onready var player = $"/root/World/player"
var already_triggered = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.connect("body_entered", self, "_on_body_entered")
	$vending.play("off")
	pass

func _on_body_entered(body):
	if not already_triggered:
		start.set_global_position(self.get_global_position())
		player.curr_checkpoint = self
		already_triggered = true
		$vending.play("on")