extends Area2D

@onready var animation_player = $"../AnimationPlayer"


func _on_body_entered(body):
	if body is CharacterBody2D:
		animation_player.play("mechanism")
