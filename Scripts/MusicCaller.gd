extends Node


export var song : String = ""
export var replace : bool = false
export var mute    : bool = false


func _ready():
	if !mute:
		SoundManager.play_music(song, replace)
	queue_free()
