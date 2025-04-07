extends Control

@onready var music = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value/10)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_check_box_toggled(toggled_on):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)
