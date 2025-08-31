extends Node2D


var canPress : bool = true

onready var animPlay    := $AnimationPlayer
onready var score       := $Control/VBoxContainer/VBoxContainer2/Score
onready var hiScore     := $Control/VBoxContainer/VBoxContainer2/HiScore
onready var hBContainer := $Control/VBoxContainer/HBoxContainer

signal retry()


func _ready() -> void:
	for button in hBContainer.get_children():
		button.connect("mouse_entered", self, "button_selected")

func button_selected() -> void:
	SoundManager.create_sound("Select")

func _on_Button_pressed():
	if canPress:
		SoundManager.create_sound("Break")
		animPlay.play_backwards("Trans")
		canPress = false

func _on_Button2_pressed():
	if canPress:
		SoundManager.play_music("")
		SoundManager.create_sound("ScreenBreak", true)
		canPress = false
		Globals.go_to_scene("res://Scenes/SelectMode.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if !canPress:
		emit_signal("retry", false)
		queue_free()
