extends Control


onready var bContainer  := $HBoxContainer
onready var tilesParent := $TilesParent
onready var instruction := $Intruction
onready var animPlay    := $AnimationPlayer


func _ready() -> void:
	if !Globals.misc["menu"]:
		tilesParent.connect("cleared", self, "start_menu")
	else:
		instruction.visible = false
		animPlay.play("StartMenu")
		set_disable(false)
	for button in bContainer.get_children():
		button.connect("mouse_entered", self, "button_selected")

func button_selected() -> void:
	SoundManager.create_sound("Select")

func set_disable(value : bool) -> void:
	for button in bContainer.get_children():
		button.disabled = value

func start_menu() -> void:
	Globals.misc["menu"] = true
	Globals.save_data(Globals.misc, Globals.SAVE_MISC_PATH)
	tilesParent.disconnect("cleared", self, "start_menu")
	instruction.visible = false
	animPlay.play("StartMenu")
	set_disable(false)

func _on_Start_pressed() -> void:
	Globals.go_to_scene("res://Scenes/SelectMode.tscn", 1)
	SoundManager.play_music("")
	SoundManager.create_sound("Break", true)
	set_disable(true)

func _on_Quit_pressed():
	get_tree().quit()

func _on_Palettes_pressed():
	Globals.go_to_scene("res://Scenes/Palettes.tscn")
	SoundManager.create_sound("Break", true)
	set_disable(true)

func _on_Settings_pressed():
	Globals.go_to_scene("res://Scenes/Settings.tscn")
	SoundManager.create_sound("Break", true)
	set_disable(true)

func _on_MusicBox_pressed():
	Globals.go_to_scene("res://Scenes/MusicBox.tscn")
	SoundManager.create_sound("Break", true)
	set_disable(true)
