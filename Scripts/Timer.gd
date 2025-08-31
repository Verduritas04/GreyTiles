extends RichTextLabel


var time : int = 35

onready var timer := $Timer

signal time()


func set_time(currentTime) -> void:
	time = currentTime
	bbcode_text = "[center]" + str(time)

func _on_Timer_timeout():
	set_time(time - 1)
	if time > 0:
		timer.start()
	else:
		emit_signal("time")
