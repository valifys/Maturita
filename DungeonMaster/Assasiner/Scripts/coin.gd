extends Area2D

@onready var game_manager = %GameManager

func _ready():
	print("ahoj")

func _on_body_entered(body):
	print("ne")
	game_manager.add_point()
	queue_free() # Replace with function body.
