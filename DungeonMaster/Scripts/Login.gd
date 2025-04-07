extends Control
@onready var username = $VBoxContainer/Username
@onready var password = $VBoxContainer/Password
@onready var http = $HTTPRequest
@onready var label = $Label


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_login_pressed():
	var form_data = JSON.stringify({"username":username.text, "password":password.text})
	http.request("http://127.0.0.1:5000/login", ["Content-Type: application/json"], HTTPClient.METHOD_POST, form_data)


func _on_http_request_request_completed(result, response_code, headers, body):
	if response_code != 200:
		label.text = "spatne jmeno nebo heslo"
		await wait(2)
		label.text = " "
	else:
		Globals.username = JSON.parse_string(body.get_string_from_utf8())["username"]
		label.text = "uzivatel "+ Globals.username+ " uspesne prihlasen"



func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/register.tscn")
