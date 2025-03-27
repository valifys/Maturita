extends AnimatableBody2D

@onready var boatsprite = get_node("Sprite2D")


func _process(float) -> void:
	if position.x > 820:
		boatsprite.flip_h = true
	if position.x < 601:
		boatsprite.flip_h = false

