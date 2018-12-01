extends Area2D

export(String) var next_scene = "res://TitleScreen/TitleScreen.tscn"
onready var fade_out = $"/root/World/switch_warning/fade_out"

func _on_gem_body_entered(body):
	$AnimatedSprite.play("collected")

func _process(delta):
	if $AnimatedSprite.animation == "collected" and $AnimatedSprite.frame == 4:
		fade_out.show()
		fade_out.fade_in()
