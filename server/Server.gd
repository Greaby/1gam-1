extends TextureRect

export (int) var capacity = 200
var viewers = 0
var streamer = 0

var buttons = []

enum STATES {NONE, ON, BROKEN}
var state = null

signal spend_money

func _ready():
	buttons = $Buttons.get_children()
	
	_change_state(STATES.NONE)
	display_lights()


func _change_state(new_state):
	match new_state:
		NONE:
			modulate = Color(1, 1, 1, 0)
		ON:
			modulate = Color(1, 1, 1, 1)
			$ViewerTimer.start()
			$BlinkTimer.stop()
			$Error.modulate = Color(1, 1, 1, 0)
			$Texts.visible = true
		BROKEN:
			viewers = 0
			streamer = 0
			$BlinkTimer.start()
			$Texts.visible = false

	state = new_state
	display_lights()


func display_lights():
	for button in buttons:
		button.off()
	
	if state == ON:
		var percent = ceil(float(viewers) / float(capacity) * buttons.size())
		for i in range(0, percent):
			buttons[i].on()


func can_drop_data(pos, data):
	match data:
		"server": 
			return _can_drop_server()
		"upgrade": 
			return _can_drop_upgrade()
		"streamer": 
			return _can_drop_streamer()
	return false

func _can_drop_server():
	if(state == NONE):
		modulate = Color(0, 1, 0, 1)
		return true
		
	modulate = Color(1, 0, 0, 1)
	return false

func _can_drop_upgrade():
	if(state == NONE):
		return false
		
	if(state == ON or state == BROKEN):
		modulate = Color(0, 1, 0, 1)
		return true
		
	modulate = Color(1, 0, 0, 1)
	return false
	
func _can_drop_streamer():
	if(state == NONE):
		return false
	
	if(state == ON):
		modulate = Color(0, 1, 0, 1)
		return true
		
	modulate = Color(1, 0, 0, 1)
	return false


func drop_data(pos, data):
	$Pop.play()
	match data:
		"server": 
			return _drop_server()
		"upgrade": 
			return _drop_upgrade()
		"streamer": 
			return _drop_streamer()


func _drop_server():
	if(state == NONE):
		_change_state(STATES.ON)
		emit_signal("spend_money", 1000)

func _drop_upgrade():
	if(state == ON):
		_add_capacity()
		emit_signal("spend_money", 1000)
	elif(state == BROKEN):
		_change_state(STATES.ON)
		emit_signal("spend_money", 1000)
		
func _drop_streamer():
	if(state == ON):
		_add_streamer()

func _add_capacity():
	capacity += 1000
	
func _add_streamer():
	streamer += 1
	
func _on_Server_mouse_exited():
	if state == NONE:
		modulate = Color(1, 1, 1, 0)
		return
		
	modulate = Color(1, 1, 1, 1)

func format_number(number):
	if(number < 1000):
		return str(number)
	elif(number < 1000000):
		return str(ceil(number/1000)) + "k"
	elif(number < 1000000000):
		return str(ceil(number/1000000)) + "m"
	elif(number < 1000000000000):
		return str(ceil(number/1000000000)) + "g"
		
func _process(delta):
	$Texts/CapacityNumber.text = format_number(capacity)
	$Texts/StreamerNumber.text = format_number(streamer)
	$Texts/ViewerNumber.text = format_number(viewers)
	
	
	if state == STATES.BROKEN and Input.is_action_pressed("click"):
		$Pop.play()
		_change_state(STATES.ON)


func _on_ViewerTimer_timeout():
	viewers += streamer * 10
	if(viewers > capacity):
		_change_state(STATES.BROKEN)
		return
		
	display_lights()


func _on_BlinkTimer_timeout():
	if($Error.modulate == Color(1, 1, 1, 0)):
		$Error.modulate = Color(1, 1, 1, 1)
		$Bang.play()
	else:
		$Error.modulate = Color(1, 1, 1, 0)
