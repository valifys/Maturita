extends Node2D

const SPEED = 60
var direction = 1
@onready var sprite2D = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

func _process(delta):
	if position.x < 1000:
		direction = 1
		sprite2D.flip_h = false
	if position.x > 1180:
		direction = -1
		sprite2D.flip_h = true
	position.x += direction * SPEED * delta
