extends Control

func _ready():
	$BGM/BGM.pressed = global.play_bgm
	$SFX/SFX.pressed = global.play_sfx
	$menu.grab_focus()

func _on_BGM_button_up():
	if global.snowheart_melody.playing:
		global.stop_snowheart()
		global.play_bgm = false
	else:
		global.play_snowheart()
		global.play_bgm = true

func _on_SFX_button_up():
	pass

func _on_menu_pressed(scene_to_load):
	global.goto_scene("res://TitleScreen/TitleScreen.tscn")