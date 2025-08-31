extends Area2D


onready var sprite := $Sprite


func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		position = get_global_mouse_position()
		sprite.frame = 1 if get_overlapping_areas() != [] else 0

func _ready() -> void:
	position = Vector2(-16, -16)
