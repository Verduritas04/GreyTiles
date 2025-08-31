extends Control


var slidePos : int = 0
var active : bool = true

export (int) var mode = 60

onready var sprite    := $Control/Sprite
onready var control   := $Control
onready var scoreText := $Control/HSNumber
onready var time      := $Control/Time

signal mode_set(xPos)


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_click") and sprite.frame == 1 and active:
		var song = SoundManager.currentSong
		Globals.mode = mode
		SoundManager.create_sound("Break")
		call_deferred("emit_signal", "mode_set", rect_position.x + 96)
		SoundManager.call_deferred("play_music", Globals.music[mode] + "Preview", true)

func _ready() -> void:
	time.text = str(mode) + " s"
	scoreText.text = str(Globals.hiScore[mode])

func _process(delta : float) -> void:
	control.rect_position.y = lerp(control.rect_position.y, slidePos, 30 * delta)

func _on_Area2D_area_entered(area : Object) -> void:
	if active:
		slidePos = -8
		sprite.frame = 1
		SoundManager.create_sound("Select")

func _on_Area2D_area_exited(area : Object) -> void:
	slidePos = 0
	sprite.frame = 0
