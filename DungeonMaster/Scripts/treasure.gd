extends AnimatableBody2D

@onready var sprite2D = $AnimatedSprite2D
@onready var score
@onready var http = $"../HTTPRequest"

func _on_area_2d_body_entered(body):
	if Globals.key:
		sprite2D.play("opening")
		print(Globals.timemins)
		print(Globals.timesecs)
		print(Globals.timemilisecs)
		Globals.timer = false
		score = str(Globals.timemins) + ":" + str(Globals.timesecs) + "," + str(Globals.timemilisecs)


func _on_http_request_request_completed(result, response_code, headers, body):
	pass # Replace with function body.
