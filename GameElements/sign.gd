extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var text = "default text"
export var alt_text = "default alternate text"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.connect("body_entered", self, "_on_body_entered")
	self.connect("body_exited", self, "_on_body_exited")
	$sign/bubble.hide()
	$sign/Label.hide()
	$sign/Label.text = text
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_body_entered(body):
	$sign/bubble.show()
	$sign/Label.show()

func _on_body_exited(body):
	$sign/bubble.hide()
	$sign/Label.hide()

func _on_sign6_area2d_body_entered(body):
	if name == "sign6":
		$sign/Label.text = alt_text
	pass # replace with function body


func _on_sign5_area2d2_body_entered(body):
	if name == "sign5":
		var world2 = $"/root/World/world2"
		world2.set_cell(82, 5, 0)
		world2.set_cell(83, 5, 1)
		world2.set_cell(84, 5, 1)
		world2.set_cell(85, 5, 1)
		world2.set_cell(86, 5, 2)
		world2.set_cell(82, 6, 6)
		world2.set_cell(83, 6, 7)
		world2.set_cell(84, 6, 7)
		world2.set_cell(85, 6, 7)
		world2.set_cell(86, 6, 8)
		$sign/Label.text = alt_text
	pass # replace with function body
