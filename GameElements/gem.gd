extends Area2D

export(String) var next_scene = "res://TitleScreen/TitleScreen.tscn"
onready var fade_out = $"/root/World/switch_warning/fade_out"

func _ready():
	self.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	$AnimatedSprite.play("collected")
	var t = Timer.new()
	t.set_wait_time(.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	fade_out.show()
	fade_out.fade_in()

func _on_fade_out_fade_finished():
	fade_out.hide()
	global.goto_scene(next_scene)
