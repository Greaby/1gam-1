extends Sprite

enum colors {off, green, orange, red}
enum blinks {none, slow, fast, shuffle}

export(colors) var color

var isOn = true

func _ready():
	match color:
		colors.green: $On.texture = load("res://server/assets/button-green.png")
		colors.orange: $On.texture = load("res://server/assets/button-orange.png")
		colors.red: $On.texture = load("res://server/assets/button-red.png")
		colors.off: 
			$On.texture = null
			isOn = false
			
	_animate()

func on():
	isOn = true
	$Timer.start()
	_animate()

func off():
	isOn = false
	$Timer.stop()
	$AnimationPlayer.play('hide')

#func _on_Timer_timeout():
	#_animate()
	
func _animate():
	if isOn:
		var animations = [blinks.none, blinks.none, blinks.none, blinks.none, blinks.slow, blinks.fast, blinks.shuffle]
		var animation = animations[randi() % animations.size()]
		
		$AnimationPlayer.play('show')
		
		match animation:
			blinks.slow: $AnimationPlayer.play("blink-slow")
			blinks.fast: $AnimationPlayer.play("blink-fast")
			blinks.shuffle: $AnimationPlayer.play("blink-shuffle")
