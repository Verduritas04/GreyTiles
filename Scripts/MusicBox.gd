extends Control


onready var description  := $Description/Label
onready var vBContainter := $Songs/ScrollContainer/VBoxContainer


func _ready() -> void:
	for button in vBContainter.get_children():
		button.connect("mouse_entered", self, "button_selected")

func button_selected() -> void:
	SoundManager.create_sound("Select")

func _on_GrayTiles_pressed():
	SoundManager.create_sound("Break")
	SoundManager.play_music("GrayTiles", true)
	description.text = tr("description_0")

func _on_GridBased_pressed():
	SoundManager.create_sound("Break")
	SoundManager.play_music("GridBased", true)
	description.text = tr("description_1")

func _on_Button_pressed():
	SoundManager.create_sound("Break")
	SoundManager.play_music("OneMore", true)
	description.text = tr("description_2")

func _on_Button2_pressed():
	SoundManager.create_sound("Break")
	SoundManager.play_music("Mono", true)
	description.text = tr("description_3")
