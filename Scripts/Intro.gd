extends Node2D


var canChangeScene : bool = true


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_click"):
		$AnimationPlayer.stop()
		change_scene()

func play_intro() -> void:
	SoundManager.create_sound("ComVer")

func _on_AnimationPlayer_animation_finished(anim_name):
	change_scene()

func change_scene() -> void:
	if canChangeScene:
		canChangeScene = false
		Globals.go_to_scene("res://Scenes/Menu.tscn")
