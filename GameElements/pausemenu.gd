extends TextureRect

var just_paused = false

func _on_continue_pressed():
	hide()
	get_tree().paused = false

func _on_home_pressed():
	get_tree().paused = false
	global.goto_scene("res://TitleScreen/TitleScreen.tscn")
	
func _process(delta):
	if get_tree().paused == true and not just_paused:
		if Input.is_action_just_pressed("ui_pause"):
			hide()
			get_tree().paused = false
	just_paused = false
