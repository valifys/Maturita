extends Node2D

const SPEED = 60
var direction = 1
@onready var sprite2D = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

func _process(delta):
	if position.x > 1100:
		direction = -1
		sprite2D.flip_h = true
	if position.x < -50:
		direction = 1
		sprite2D.flip_h = false
	position.x += direction * SPEED * delta
