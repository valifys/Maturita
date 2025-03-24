extends Node

@onready var score = 0
@onready var score_label = $"../CharacterBody2D/Camera2D/Score_label"
@onready var http = $"../HTTPRequest"

#func _ready():
#	var headers = ["Content-Type: application/json"]
#	http.request_completed.connect(_get_auto)
#	http.request("http://127.0.0.1:5000/hraci", headers)
#print("ddddd")

#func _get_auto(result, response_code, headers, body):
#	var json = JSON.parse_string(body.get_string_from_utf8())
#	print(json[0]["spz"])
