extends HSlider


export (String,
"Master",
"SFX",
"Music") var type = "Master"


func _ready() -> void:
	connect("value_changed", self, "update_volume")
	value = Globals.settings[type] * 100

func update_volume(set_value) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(type), linear2db(float(set_value * 0.01)))
	Globals.settings[type] = set_value * 0.01
	Globals.save_data(Globals.settings, Globals.SAVE_SETTINGS_PATH)
	if type != "Music":
		SoundManager.create_sound("Select")
