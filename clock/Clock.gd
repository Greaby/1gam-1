extends Node2D

var angle = 0

var is_night = false

signal time_changed
signal day_end

func _ready():
	$AnimationPlayer.play('SETUP')


func _on_Timer_timeout():
	angle += 1
	if angle >= 360:
		angle = 0
		if is_night:
			$AnimationPlayer.play('day')
			emit_signal('day_end')
		else:
			$AnimationPlayer.play('night')
		is_night = !is_night
	
	emit_signal('time_changed', deg2rad(angle))
