extends Node2D


onready var animPlayer := $AnimationPlayer

signal scene_entered(exitDoor)


func change_scene(newScene : String, delay : int = 0.1, exitDoor : int = -1, fadeInAnim : String = "FadeIn",\
fadeOutAnim : String = "FadeOut") -> void:
	yield(get_tree().create_timer(delay), "timeout")
	animPlayer.play(fadeInAnim)
	yield(animPlayer, "animation_finished")
	if get_tree().change_scene(newScene) == OK:
		if exitDoor > -1:
			call_deferred("emit_signal", "scene_entered", exitDoor)
		animPlayer.play(fadeOutAnim)
		yield(animPlayer, "animation_finished")
		queue_free()

func reload_scene(exitDoor : int = -1, fadeInAnim : String = "FadeIn",\
fadeOutAnim : String = "FadeOut", delay : int = 0.1) -> void:
	yield(get_tree().create_timer(delay), "timeout")
	animPlayer.play(fadeInAnim)
	yield(animPlayer, "animation_finished")
	if get_tree().reload_current_scene() == OK:
		if exitDoor > -1:
			call_deferred("emit_signal", "scene_entered", exitDoor)
		animPlayer.play(fadeOutAnim)
		yield(animPlayer, "animation_finished")
		queue_free()

