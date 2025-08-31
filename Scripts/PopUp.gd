extends Label


func _process(delta : float) -> void:
	rect_position.y -= 4 * delta

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
