extends AnimatableBody2D

@onready var sprite2D = $AnimatedSprite2D
@onready var score
@onready var http = $HTTPRequest
var best_score
signal new_score
@onready var victory = $"../Player/Camera2D/Button"
@onready var victory2 = $"../Player/Camera2D/Button2"

func _on_area_2d_body_entered(body):
	if Globals.key:
		sprite2D.play("opening")
		print(Globals.timesecs)
		Globals.timer = false
		score = int(Globals.timesecs)
		victory.visible = true
		victory2.visible = true
		if Globals.username:
			get_score()
		


func get_score():
	http.request("http://127.0.0.1:5000/score/" + Globals.username, ["Content-Type: application/json"], HTTPClient.METHOD_GET)



func _on_http_request_request_completed(result, response_code, headers, body):
	if response_code == 200:
		best_score = JSON.parse_string(body.get_string_from_utf8())["score"]
		if best_score > float(score):
			new_score.emit()


func _on_new_score():
	var form_data = JSON.stringify({"score": score})
	http.request("http://127.0.0.1:5000/score/" + Globals.username, ["Content-Type: application/json"], HTTPClient.METHOD_PUT, form_data)
