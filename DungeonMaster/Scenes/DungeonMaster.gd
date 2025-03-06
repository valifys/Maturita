extends Label

var text_to_display: String = "DUNGEON MASTER"

var current_index: int = 0

var interval: float = 0.12
var time_accumulator: float = 0.0

func _process(delta):
	if current_index < text_to_display.length():
		time_accumulator += delta
		if time_accumulator >= interval:
			time_accumulator -= interval
			text += text_to_display[current_index]
			current_index += 1
			visible_characters += 1
