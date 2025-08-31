extends Node


const Sound = preload("res://Scenes/Sound.tscn")
const Sound2d = preload("res://Scenes/2DSound.tscn")

const MUSIC : Dictionary = {
	"GridBasedPreview" : {"sound" : preload("res://Music/GridBased.ogg")},
	"GridBased" : {"sound" : preload("res://Music/GridBased.ogg")},
	"GrayTiles" : {"sound" : preload("res://Music/GrayTiles.ogg")},
	"OneMorePreview" : {"sound" : preload("res://Music/OneMorePreview.ogg")},
	"OneMore" : {"sound" : preload("res://Music/OneMore.ogg")},
	"MonoPreview" : {"sound" : preload("res://Music/MonoPreview.ogg")},
	"Mono" : {"sound" : preload("res://Music/Mono.ogg")}
}

const SOUNDS : Dictionary = {
	"ComVer" : {"sound" : preload("res://SFX/ComanVerdura.wav"), "pitchRange" : [1.0, 1.0],
		"volume" : 0},
	"Select" : {"sound" : preload("res://SFX/Select.wav"), "pitchRange" : [1.0, 2.0],
		"volume" : 0},
	"Slide" : {"sound" : preload("res://SFX/Slide.wav"), "pitchRange" : [0.3, 0.6],
		"volume" : -5},
	"Break" : {"sound" : preload("res://SFX/Break.wav"), "pitchRange" : [0.5, 0.8],
		"volume" : -8},
	"ScreenBreak" : {"sound" : preload("res://SFX/ScreenBreak.wav"), "pitchRange" : [1.0, 1.5],
		"volume" : 0}
}

var currentSong : String = ""

export var mute = false

onready var music := $Music


func play_music(songId : String, replay : bool = false) -> void:
	if !mute:
		if songId == "":
			music.stop()
		elif currentSong != songId or replay:
			music.stream = MUSIC[songId]["sound"]
			music.play()
		currentSong = songId

func create_sound(soundId : String, global : bool = false) -> void:
	if soundId != "":
		var sound = Sound.instance()
		get_tree().current_scene.call_deferred("add_child", sound) if !global else call_deferred("add_child", sound)
		sound.stream = SOUNDS[soundId]["sound"]
		sound.volume_db = SOUNDS[soundId]["volume"]
		sound.pitch_scale = rand_range(SOUNDS[soundId]["pitchRange"][0],\
		SOUNDS[soundId]["pitchRange"][0])
		sound.play()

func create_sound2d(soundId : String, pos : Vector2, global : bool = false):
	if soundId != "":
		var sound = Sound2d.instance()
		get_tree().current_scene.add_child(sound) if !global else add_child(sound)
		sound.position = pos
		sound.stream = SOUNDS[soundId]["sound"]
		sound.pitch_scale = rand_range(SOUNDS[soundId]["pitchRange"][0], SOUNDS[soundId]["pitchRange"][1])
		sound.volume_db = SOUNDS[soundId]["volume"]
		sound.play()
