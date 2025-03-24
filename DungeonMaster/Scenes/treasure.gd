extends AnimatableBody2D

@onready var sprite2D = $AnimatedSprite2D


func _on_area_2d_body_entered(body):

	if Globals.key:
		sprite2D.play("opening")
		print(Globals.timemins)
		print(Globals.timesecs)
		print(Globals.timemilisecs)
		Globals.timer = false
		
