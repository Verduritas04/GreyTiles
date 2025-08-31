extends Node


const SAVE_DIRECTORY = "user://saves/"
const SAVE_SCORE_PATH = SAVE_DIRECTORY + "saveThisAreNotScores.dat"
const SAVE_MUSIC_PATH = SAVE_DIRECTORY + "saveMusicAndStuff.dat"
const SAVE_MISC_PATH = SAVE_DIRECTORY + "saveMisc.dat"
const SAVE_SETTINGS_PATH = SAVE_DIRECTORY + "saveSettings.dat"

const Trans = preload("res://Scenes/Transition.tscn")

var mode    : int = 15
var score   : int = 0


var hiScore : Dictionary = {
	60 : 0,
	30 : 0,
	15 : 0
}
var music : Dictionary = {
	60 : "GridBased",
	30 : "OneMore",
	15 : "Mono"
}
var settings : Dictionary = {
	"palette" :
	[Color.black,
	Color(0.33, 0.33, 0.33, 1),
	Color(0.67, 0.67, 0.67, 1),
	Color.white],
	"fullscreen" : true,
	"screenshake" : true,
	"language" : "",
	"resolution" : Vector2(1280, 720),
	"Master" : 1,
	"SFX" : 1,
	"Music" : 1
}
var misc : Dictionary = {
	"menu" : false
}


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	hiScore = load_data(hiScore, SAVE_SCORE_PATH)
	music = load_data(music, SAVE_MUSIC_PATH)
	misc = load_data(misc, SAVE_MISC_PATH)
	settings = load_data(settings, SAVE_SETTINGS_PATH)
	
	if settings["language"] != "":
		TranslationServer.set_locale(settings["language"])
	OS.window_size = settings["resolution"]
	OS.window_position = OS.get_screen_size() * 0.5 - OS.window_size * 0.5
	OS.window_fullscreen = settings["fullscreen"]
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(settings["Master"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(settings["SFX"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(settings["Music"]))
	
	var gbRect = GbShader.get_child(0)
	gbRect.material.set("shader_param/darkest", settings["palette"][0])
	gbRect.material.set("shader_param/dark", settings["palette"][1])
	gbRect.material.set("shader_param/light", settings["palette"][2])
	gbRect.material.set("shader_param/lightest", settings["palette"][3])

func save_data(data, path) -> void:
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIRECTORY):
		dir.make_dir_recursive(SAVE_DIRECTORY)
	var file = File.new()
	var error = file.open_encrypted_with_pass(path, File.WRITE, "UhgkJHJKgJUYG7576547.-'=987097?=)?$·_____9")
	if error == OK:
		file.store_var(data)
		file.close()
	else:
		file.close()
	# Add an else condicion for if it can't save

func load_data(data, path) -> Dictionary:
	var file = File.new()
	if file.file_exists(path):
		var error = file.open_encrypted_with_pass(path, File.READ, "UhgkJHJKgJUYG7576547.-'=987097?=)?$·_____9")
		if error == OK:
			var loadData = file.get_var()
			file.close()
			return loadData
		else:
			file.close()
			return data
	else:
		return data
		# Add an else condicion for if it can't load

func go_to_scene(scenePath : String, delay : float = 0.1) -> void:
	var trans = Trans.instance()
	get_tree().root.add_child(trans)
	trans.change_scene(scenePath, delay)
