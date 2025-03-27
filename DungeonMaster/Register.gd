extends Control
@onready var username = $VBoxContainer/Username
@onready var password = $VBoxContainer/Password
@onready var http = $HTTPRequest
@onready var label = $Label

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func _on_button_pressed():
	var form_data = JSON.stringify({"username":username.text, "password":password.text})
	http.request("http://127.0.0.1:5000/register", ["Content-Type: application/json"], HTTPClient.METHOD_POST, form_data)


func _on_http_request_request_completed(result, response_code, headers, body):
	if response_code != 200:
		label.text = "uzivatel jiz existuje"
		await wait(2)
		label.text = " "
	else:
		label.text = JSON.parse_string(body.get_string_from_utf8())["success"]


func _on_button_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/login.tscn")
