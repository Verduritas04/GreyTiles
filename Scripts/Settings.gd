extends Control


onready var fullscreen  := $Panel/VBoxContainer/Fullscreen
onready var screenshake := $Panel/VBoxContainer/Screenshake
onready var resolution  := $Panel/VBoxContainer/HBoxContainer2/Resolution
onready var language    := $Panel/VBoxContainer/HBoxContainer/Language


func _ready() -> void:
	fullscreen.pressed = Globals.settings["fullscreen"]
	screenshake.pressed = Globals.settings["screenshake"]
	language.add_item("English")
	language.add_item("Español")
	resolution.add_item("320x180")
	resolution.add_item("640x360")
	resolution.add_item("960x540")
	resolution.add_item("1280x720")
	resolution.add_item("1600x900")
	resolution.add_item("1920x1080")
	match Globals.settings["resolution"]:
		Vector2(320, 180):
			resolution.select(0)
		Vector2(640, 360):
			resolution.select(1)
		Vector2(960, 540):
			resolution.select(2)
		Vector2(1280, 720):
			resolution.select(3)
		Vector2(1600, 900):
			resolution.select(4)
		Vector2(1920, 1080):
			resolution.select(5)
	if TranslationServer.get_locale() == "en":
		language.select(0)
	else:
		language.select(1)
	resolution.disabled = fullscreen.pressed

func save_settings() -> void:
	Globals.save_data(Globals.settings, Globals.SAVE_SETTINGS_PATH)

func _on_Fullscreen_toggled(button_pressed):
	resolution.disabled = button_pressed
	Globals.settings["fullscreen"] = button_pressed
	OS.window_fullscreen = button_pressed
	save_settings()
	SoundManager.create_sound("Break")

func _on_Screenshake_toggled(button_pressed):
	Globals.settings["screenshake"] = button_pressed
	if !button_pressed:
		screenshake.text = tr("you_monster")
	else:
		screenshake.text = tr("screenshake")
	save_settings()
	SoundManager.create_sound("Break")

func _on_Resolution_item_selected(index):
	SoundManager.create_sound("Break")
	match index:
		0:
			Globals.settings["resolution"] = Vector2(320, 180)
		1:
			Globals.settings["resolution"] = Vector2(640, 360)
		2:
			Globals.settings["resolution"] = Vector2(960, 540)
		3:
			Globals.settings["resolution"] = Vector2(1280, 720)
		4:
			Globals.settings["resolution"] = Vector2(1600, 900)
		5:
			Globals.settings["resolution"] = Vector2(1920, 1080)
	Globals.save_data(Globals.settings, Globals.SAVE_SETTINGS_PATH)
	OS.window_size = Globals.settings["resolution"]
	OS.window_position = OS.get_screen_size() * 0.5 - OS.window_size * 0.5

func _on_HSlider_value_changed(value):
	$Panel/VBoxContainer/HBoxContainer3/Label2.text = str(int(value)) + " %"

func _on_HSlider_value_changed2(value):
	$Panel/VBoxContainer/HBoxContainer4/Label3.text = str(int(value)) + " %"

func _on_HSlider_value_changed3(value):
	$Panel/VBoxContainer/HBoxContainer5/Label4.text = str(int(value)) + " %"

func _on_Language_item_selected(index):
	SoundManager.create_sound("Break")
	match index:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("es")
	Globals.settings["language"] = TranslationServer.get_locale()
	Globals.save_data(Globals.settings, Globals.SAVE_SETTINGS_PATH)

func _on_Fullscreen_mouse_entered():
	SoundManager.create_sound("Select")

func _on_Screenshake_mouse_entered():
	SoundManager.create_sound("Select")

func _on_Language_mouse_entered():
	SoundManager.create_sound("Select")

func _on_Language_pressed():
	SoundManager.create_sound("Select")

func _on_Resolution_mouse_entered():
	SoundManager.create_sound("Select")

func _on_Resolution_pressed():
	SoundManager.create_sound("Select")

func _on_HSlider_mouse_entered():
	SoundManager.create_sound("Select")

func _on_HSlider_drag_started():
	SoundManager.create_sound("Select")

func _on_HSlider_mouse_entered2():
	SoundManager.create_sound("Select")

func _on_HSlider_drag_started2():
	SoundManager.create_sound("Select")

func _on_HSlider_mouse_entered3():
	SoundManager.create_sound("Select")

func _on_HSlider_drag_started3():
	SoundManager.create_sound("Select")
