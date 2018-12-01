extends Control

var scene_path_to_load

func _ready():
	global.stop_urban()
	if global.play_bgm and not global.snowheart_melody.playing:
		global.play_snowheart()
	$Buttons/NewGame.grab_focus()
	$Buttons/NewGame.connect("pressed", self, "_on_Button_pressed", [$Buttons/NewGame.scene_to_load])

func _on_Button_pressed(scene_to_load):
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = scene_to_load

func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	global.goto_scene(scene_path_to_load)

func _on_Options_pressed():
	global.goto_scene("res://TitleScreen/Options.tscn")
