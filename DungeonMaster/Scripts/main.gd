extends Node2D

@onready var music = $AudioStreamPlayer
@onready var score = $Player/Timer
var time = 0.0
@onready var seconds = $Player/Camera2D/seconds
@onready var username = $Player/Camera2D/Player

func _ready():
	music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.timer:
		time += delta
		var secs = fmod(time,400)
		seconds.text = "%02d." % int(secs)
		Globals.timesecs = int(secs)


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		get_tree().change_scene_to_file("res://Scenes/death.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
