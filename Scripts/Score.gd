extends RichTextLabel


var score : int = 0


func _process(delta : float) -> void:
	if score < Globals.score:
		score = clamp(score + 2, 0, Globals.score)
	elif score > Globals.score:
		score = Globals.score
	bbcode_text = "[center]" + str(score)
