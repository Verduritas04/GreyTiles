extends Position2D


var ofset  = Vector2(0, 0)
var spd    = Vector2(12, 10)
var accel = 8

onready var timer := $Timer
onready var base  := $Base


func _process(delta : float) -> void:
	if ofset == Vector2.ZERO:
		return
	
	ofset.x = move_toward(ofset.x, 0, accel * delta)
	ofset.y = move_toward(ofset.y, 0, accel * delta)
	base.position = Vector2(cos(timer.time_left * spd.x), sin(timer.time_left * spd.y)) * ofset

func shake(setOfset = Vector2(3, 3), setSpd = Vector2(25, 23), setAccel = 4) -> void:
	if Globals.settings["screenshake"]:
		ofset = setOfset
		spd = setSpd
		accel = setAccel
