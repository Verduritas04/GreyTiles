extends AudioStreamPlayer2D


func _on_2DSound_finished():
	queue_free()
	
