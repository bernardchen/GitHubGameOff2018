extends Node

var loader
var wait_frames
var time_max = 100 # msec
var current_scene

var play_bgm = true
var play_sfx = true
var snowheart_melody
var urban_spelunking

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	
	#LOAD SCREEN
	var anim_node = load("res://TitleScreen/Load.tscn")
	anim_node = anim_node.instance()
	anim_node.set_name("animation")
	add_child(anim_node)
	anim_node.hide()
	get_node("animation").stop()
	
	#MUSIC
	snowheart_melody = load("res://TitleScreen/Snowheart Melody.tscn")
	snowheart_melody = snowheart_melody.instance()
	urban_spelunking = load("res://TitleScreen/Urban Spelunking.tscn")
	urban_spelunking = urban_spelunking.instance()
	add_child(snowheart_melody)
	add_child(urban_spelunking)
	
func play_snowheart():
	snowheart_melody.play()
	
func stop_snowheart():
	snowheart_melody.stop()
	
func play_urban():
	urban_spelunking.play()

func stop_urban():
	urban_spelunking.stop()

func goto_scene(path): # game requests to switch to this scene
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		print("LOADER IS NULL")
		return
	set_process(true)

	current_scene.queue_free() # get rid of the old scene

	# start your "loading..." animation
	if path != "res://TitleScreen/TitleScreen.tscn" and path != "res://TitleScreen/Options.tscn" and path != "res://EndScene/EndCard.tscn":
		get_node("animation").show()
		get_node("animation").play()

	wait_frames = 1

func _process(time):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return

	if wait_frames > 0: # wait for frames to let the "loading" animation to show up
		wait_frames -= 1
		return

	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: # use "time_max" to control how much time we block this thread

		# poll your loader
		var err = loader.poll()

		if err == ERR_FILE_EOF: # load finished
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			get_node("animation").hide()
			get_node("animation").stop()
			break
		elif err == OK:
			break
		else: # error during loading
			loader = null
			print("ERROR DURING LOADING")
			get_tree().quit()
			break

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)