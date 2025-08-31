extends Node2D


const Retry = preload("res://Scenes/Retry.tscn")

var tiles : Array
var playable : bool
var timer
var cam

export (bool) var menu = false

signal cleared()


func _ready() -> void:
	Globals.score = 0
	timer = get_tree().current_scene.get_node_or_null("Timer")
	cam = get_tree().current_scene.get_node_or_null("Cam")
	if timer != null:
		timer.connect("time", self, "finish_game")
		timer.set_time(Globals.mode)
	
	if !menu:
		SoundManager.play_music(Globals.music[Globals.mode])
	
	yield(get_tree().create_timer(1), "timeout")
	start_game(true)

func start_game(connect : bool) -> void:
	randomize()
	if timer != null:
		timer.timer.start()
	create_board(connect)
	spawn_gray_tiles()
	check_if_playable()
	if timer != null:
		timer.timer.set_paused(false)

func create_board(connect : bool) -> void:
	playable = false
	var prevFrame = -1
	for tile in get_children():
		if connect:
			tile.connect("end", self, "end")
		tile.active = false
		tile.coll.disabled = true
		tile.points = 5
		tile.animPlay2.play_backwards("Fade")
		tile.sprite.frame = 0
		tile.position = tile.startPos
		tile.value = randi() % 2
		if prevFrame == tile.value and !playable:
			playable = true
		else:
			tiles.append(tile)
		prevFrame = tile.value
		tile.call_deferred("set_tile")

func spawn_gray_tiles() -> void:
	for i in 2:
		var tileId = randi() % tiles.size()
		tiles[tileId].value = 2
		tiles[tileId].points = 10
		tiles.remove(tileId)

func check_if_playable() -> void:
	if !playable:
		var selectTile = tiles[randi() % tiles.size()]
		selectTile.value = abs(selectTile.value - 1)
	tiles.clear()

func end() -> void:
	if cam != null:
		cam.shake()
	emit_signal("cleared")
	SoundManager.create_sound("ScreenBreak")
	for tile in get_children():
		Globals.score += tile.points
		tile.active = false
		tile.fade_away(true)
	if timer != null:
		timer.set_time(timer.time + 1)
		timer.timer.set_paused(true)
	yield(get_tree().create_timer(2), "timeout")
	start_game(false)

func finish_game() -> void:
	for tile in get_children():
		tile.coll.disabled = true
		tile.active = false
		tile.animPlay2.play("Fade")
	var retry = Retry.instance()
	get_tree().current_scene.add_child(retry)
	retry.connect("retry", self, "start_game")
	retry.score.text = tr("score") + str(Globals.score)
	if Globals.score < Globals.hiScore[Globals.mode]:
		retry.hiScore.text = tr("hi_score") + str(Globals.hiScore[Globals.mode])
	else:
		Globals.hiScore[Globals.mode] = Globals.score
		retry.hiScore.text = tr("new_hi_score") + str(Globals.hiScore[Globals.mode])
		Globals.save_data(Globals.hiScore, Globals.SAVE_SCORE_PATH)
	Globals.score = 0
	timer.set_time(Globals.mode)
