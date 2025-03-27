extends Control
@onready var First = $VBoxContainer/First
@onready var Second = $VBoxContainer/Second
@onready var Third = $VBoxContainer/Third
@onready var Fourth = $VBoxContainer/Fourth
@onready var Fifth = $VBoxContainer/Fifth
@onready var http = $HTTPRequest

func _ready():
	http.request("http://127.0.0.1:5000/users",["Content-Type: application/json"] ,HTTPClient.METHOD_GET)



func _on_http_request_request_completed(result, response_code, headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())["data"]
	First.text = "1. " + str(data[0]["username"]) + " " + str(data[0]["score"])
	Second.text = "2. " + str(data[1]["username"]) + " " + str(data[1]["score"])


	
	
	


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
