extends Node2D


const PopUp = preload("res://Scenes/PopUp.tscn")

var startPos : Vector2
var mousePos : Vector2 = position + Vector2(8, 8)
var value  : int = 0
var points : int = 5
var active   : bool = false
var moused   : bool = false
var selected : bool = false

export (Vector2) var basePosition = Vector2.ZERO
export (Vector2) var limitInit    = Vector2(96, 24)
export (Vector2) var limitEnd     = Vector2(208, 136)

onready var sprite    := $Sprite
onready var animPlay  := $AnimationPlayer
onready var animPlay2 := $AnimationPlayer2
onready var raycast   := $RayCast2D
onready var coll      := $Area2D/CollisionShape2D

signal end()


func _input(event : InputEvent) -> void:
	if Input.is_action_just_pressed("ui_click") and moused and active:
		selected = true
		mousePos = get_global_mouse_position()
	if event is InputEventMouseMotion and Input.is_action_pressed("ui_click") and \
	moused and selected and active and mousePos.distance_squared_to(get_global_mouse_position()) > 4:
		if abs(event.relative.x) >= abs(event.relative.y):
			move(Vector2(sign(event.relative.x), 0))
		else:
			move(Vector2(0, sign(event.relative.y)))
		selected = false

func _process(delta : float) -> void:
	sprite.position.x = lerp(sprite.position.x, 8, 30 * delta)
	sprite.position.y = lerp(sprite.position.y, 8, 30 * delta)

func move(direction : Vector2) -> void:
	raycast.cast_to = direction * 3
	raycast.position = Vector2(8, 8) + direction * 8
	raycast.force_raycast_update()
	var collider
	if raycast.is_colliding():
		collider = raycast.get_collider().get_parent()
	if !raycast.is_colliding() or collider.active and collider.value == value:
		position.x = clamp(position.x + direction.x * 16, limitInit.x, limitEnd.x)
		position.y = clamp(position.y + direction.y * 16, limitInit.y, limitEnd.y)
		sprite.position += direction * -16
		if points != 0:
			SoundManager.create_sound("Slide")
		if collider != null:
			Globals.score += 1 if points != 0 else 0
			set_pop_up(1)
			if points != 0:
				SoundManager.create_sound("Break")
			points = 0
			animPlay2.play("Fade")
			if value == 2:
				emit_signal("end")
	animPlay.play("Shake")

func _ready() -> void:
	startPos = position

func set_tile() -> void:
	yield(get_tree().create_timer(((position.x - basePosition.x) + (position.y - basePosition.y) * 8)\
	* 0.001), "timeout")
	animPlay2.play_backwards("Fade")
	sprite.frame = value
	active = true
	coll.disabled = false

func fade_away(show : bool = false) -> void:
	yield(get_tree().create_timer(((position.x - basePosition.x) + (position.y - basePosition.y) * 8)\
	* 0.001), "timeout")
	if show:
		if points != 0:
			SoundManager.create_sound("Select")
			set_pop_up(points)
	animPlay2.play("Fade")

func set_pop_up(puValue) -> void:
	var popUp = PopUp.instance()
	get_tree().current_scene.add_child(popUp)
	popUp.text = "+" + str(puValue)
	popUp.rect_position = position

func _on_Area2D_area_entered(area):
	moused = true
	if active:
		if points != 0:
			SoundManager.create_sound("Select")
		if animPlay.current_animation != "Shake":
			animPlay.play("ShakeMini")

func _on_Area2D_area_exited(area):
	moused = false
	selected = false
