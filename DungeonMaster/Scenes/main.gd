extends Node2D

@onready var score = $Player/Timer
var time = 0.0
@onready var miliseconds = $Player/Camera2D/miliseconds
@onready var seconds = $Player/Camera2D/seconds
@onready var minutes = $Player/Camera2D/minutes

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.timer:
		time += delta
		var msec = fmod(time,1)*100
		var secs = fmod(time,60)
		var mins = fmod(time,3600)/60
		minutes.text = "%02d:" % int(mins)
		seconds.text = "%02d." % int(secs)
		miliseconds.text = "%02d" % int(msec)
		Globals.timesecs = int(secs)
		Globals.timemins = int(mins)
		Globals.timemilisecs = int(msec)
