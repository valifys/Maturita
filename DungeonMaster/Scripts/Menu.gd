extends Control


# Called when the node enters the scene tree for the first time.
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_login_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/login.tscn")
