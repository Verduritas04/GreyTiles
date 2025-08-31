extends Control

export var colors : Array = [
	[Color.black,
	Color(0.33, 0.33, 0.33, 1),
	Color(0.67, 0.67, 0.67, 1),
	Color.white],
	[Color.black,
	Color(0.33, 0.33, 0.33, 1),
	Color(0.67, 0.67, 0.67, 1),
	Color.white],
	[Color.black,
	Color(0.33, 0.33, 0.33, 1),
	Color(0.67, 0.67, 0.67, 1),
	Color.white],
	[Color.black,
	Color(0.33, 0.33, 0.33, 1),
	Color(0.67, 0.67, 0.67, 1),
	Color.white],
	[Color.black,
	Color(0.33, 0.33, 0.33, 1),
	Color(0.67, 0.67, 0.67, 1),
	Color.white],
	[Color.black,
	Color(0.33, 0.33, 0.33, 1),
	Color(0.67, 0.67, 0.67, 1),
	Color.white],
	[Color.black,
	Color(0.33, 0.33, 0.33, 1),
	Color(0.67, 0.67, 0.67, 1),
	Color.white]
]

onready var vBContainter := $Panel/VBoxContainer


func _ready() -> void:
	for button in vBContainter.get_children():
		button.connect("mouse_entered", self, "button_selected")

func set_palette(id : int) -> void:
	Globals.settings["palette"] = colors[id]
	Globals.save_data(Globals.settings, Globals.SAVE_SETTINGS_PATH)
	var gbRect = GbShader.get_child(0)
	gbRect.material.set("shader_param/darkest", colors[id][0])
	gbRect.material.set("shader_param/dark", colors[id][1])
	gbRect.material.set("shader_param/light", colors[id][2])
	gbRect.material.set("shader_param/lightest", colors[id][3])

func button_selected() -> void:
	SoundManager.create_sound("Select")

func _on_Button_pressed():
	SoundManager.create_sound("Break")
	set_palette(0)

func _on_Button2_pressed():
	SoundManager.create_sound("Break")
	set_palette(1)

func _on_Button3_pressed():
	SoundManager.create_sound("Break")
	set_palette(2)

func _on_Button4_pressed():
	SoundManager.create_sound("Break")
	set_palette(3)

func _on_Button5_pressed():
	SoundManager.create_sound("Break")
	set_palette(4)

func _on_Button6_pressed():
	SoundManager.create_sound("Break")
	set_palette(5)

func _on_Button7_pressed():
	SoundManager.create_sound("Break")
	set_palette(6)

func _on_Cross_cross():
	for button in vBContainter.get_children():
		button.disabled = true
