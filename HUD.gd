extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func update_time(time, isNight):
	if(isNight):
		$TimeLabel.text = "Nuit "
	else:
		$TimeLabel.text = "Jour "
		
	$TimeLabel.text += str(time)
	
func update_money(money):
	$MoneyLabel.text = str(money) + "$"