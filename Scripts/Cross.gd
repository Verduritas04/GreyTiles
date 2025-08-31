extends Area2D


var disabled = false

export (String) var scenePath = "res://Scenes/Menu.tscn"

onready var sprite := $Sprite

signal cross()


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_click"):
		if sprite.frame == 1:
			disabled = true
			sprite.frame = 0
			Globals.go_to_scene(scenePath)
			SoundManager.create_sound("Break")
			emit_signal("cross")

func _on_Cross_area_entered(area):
	if !disabled:
		SoundManager.create_sound("Select")
		sprite.frame = 1

func _on_Cross_area_exited(area):
	sprite.frame = 0
