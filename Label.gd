extends Label

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

func get_drag_data(pos):
	# Use another colorpicker as drag preview
	var server = load("res://server/Server.tscn")
	var node = server.instance()
	
	set_drag_preview(node)
	# Return color as drag data
	return node