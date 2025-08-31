extends Button


export (bool) var delete = false


func _ready() -> void:
	if delete:
		queue_free()
