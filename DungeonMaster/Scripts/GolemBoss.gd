extends AnimatableBody2D

const SPEED = 70
var direction = 1
var moving = false
var timer = 0
@onready var sprite2D = $AnimatedSprite2D

func _physics_process(delta):
	if moving:
		position.x += direction * SPEED * delta

		if position.x < 1000:
			direction = 1
			sprite2D.flip_h = false
		elif position.x > 1439:
			direction = -1
			sprite2D.flip_h = true
			
func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		moving = true
		sprite2D.play("move")


func _on_area_2d_2_body_entered(body):
	if body is CharacterBody2D:
		timer ++ 1
		sprite2D.play("attack")
	if timer == 2:
		sprite2D.play("move")
