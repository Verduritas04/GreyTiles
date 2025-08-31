extends Control


onready var modesContainer := $HBoxContainer
onready var rLabel         := $HBoxContainer2/RichTextLabel
onready var animPlay       := $AnimationPlayer
onready var play           := $Play
onready var arrow          := $Arrow
onready var cross          := $Cross


func _ready() -> void:
	rLabel.bbcode_text = tr("select_game_mode")
	cross.connect("cross", self, "disable")
	for mode in modesContainer.get_children():
		mode.connect("mode_set", self, "set_text")

func set_text(xPos) -> void:
	rLabel.bbcode_text = tr("game_mode") + str(Globals.mode) + tr("seconds_song") + Globals.music[Globals.mode]
	animPlay.play("Bounce")
	play.disabled = false
	play.text = tr("click_to_play")
	arrow.position.x = xPos

func _on_Play_pressed():
	SoundManager.play_music("")
	SoundManager.create_sound("ScreenBreak", true)
	Globals.go_to_scene("res://Scenes/Game.tscn", 1)
	disable()

func disable() -> void:
	play.disabled = true
	for mode in modesContainer.get_children():
		mode.active = false
