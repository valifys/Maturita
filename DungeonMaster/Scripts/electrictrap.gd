extends AnimatableBody2D

@onready var activetrap = $Area2D/CollisionShape2D
@onready var timer = $Area2D/TimerA
var active = false 

func _ready():
	change()
	
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
func change():
	active = !active
	await wait(3)
	change()
	
func _on_area_2d_body_entered(body):
	if active and body is CharacterBody2D:
		get_tree().change_scene_to_file("res://Scenes/death.tscn")
		


