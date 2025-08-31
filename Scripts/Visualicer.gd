extends Node2D


export (int) var definition = 32
export (int) var maxDb      = -16
export (int) var minDb      = -55
export (float) var width        = 1024.0
export (float) var height       = 200.0
export (float) var minFrequency = 20.0
export (float) var maxFrequency = 20000.0
export (float) var thickness    = 5.0
export (float) var accel        = 20.0
export (Color) var color = Color.white

var histogram : Array = []

onready var spectrum = AudioServer.get_bus_effect_instance(2, 0)


func _ready() -> void:
	minDb += SoundManager.music.volume_db
	maxDb += SoundManager.music.volume_db
	for i in range(definition):
		histogram.append(0)

func _process(delta : float) -> void:
	var freq = minFrequency
	var interval = (maxFrequency - minFrequency) / definition
	
	for i in range(definition):
		
		var freqRangeLow = float(freq - minFrequency) / float(maxFrequency - minFrequency)
		freqRangeLow = freqRangeLow * freqRangeLow * freqRangeLow * freqRangeLow
		freqRangeLow = lerp(minFrequency, maxFrequency, freqRangeLow)
		
		freq += interval
		
		var freqRangeHigh = float(freq - minFrequency) / float(maxFrequency - minFrequency)
		freqRangeHigh = freqRangeHigh * freqRangeHigh * freqRangeHigh * freqRangeHigh
		freqRangeHigh = lerp(minFrequency, maxFrequency, freqRangeHigh)
		
		var mag = spectrum.get_magnitude_for_frequency_range(freqRangeLow, freqRangeHigh)
		mag = linear2db(mag.length())
		mag = (mag - minDb) / (maxDb - minDb)
		
		mag += 0.3 * ((freq - minFrequency) / (maxFrequency - minFrequency))
		mag = clamp(mag, 0.01, 1)
		
		histogram[i] = lerp(histogram[i], mag, accel * delta)
		histogram[i] = clamp(histogram[i], 0.05, 1)
	
	update()

func _draw() -> void:
	var drawPos = Vector2(0, 0)
	var wInterval = width / definition
	
#	draw_line(Vector2(-thickness * 0.5, -height),\
#	Vector2(width + thickness * 0.5, -height), color, thickness * 0.5, false)
	
	for i in range(definition):
		draw_line(drawPos, drawPos + Vector2(0, -histogram[i] * height), color, thickness, false)
		drawPos.x += wInterval
