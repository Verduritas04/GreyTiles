extends Button


export (String) var song = "GridBased"

onready var parent = get_parent().get_parent()


func _ready() -> void:
	connect("pressed", self, "_on_BMusic_pressed")
	connect("mouse_entered", self, "button_selected")

func _on_BMusic_pressed():
	if parent.active:
		Globals.music[parent.mode] = song
		Globals.save_data(Globals.music, Globals.SAVE_MUSIC_PATH)
		SoundManager.call_deferred("play_music", Globals.music[parent.mode] + "Preview", true)
		parent.call_deferred("emit_signal", "mode_set", parent.rect_position.x + 96)

func button_selected() -> void:
	SoundManager.create_sound("Select")
