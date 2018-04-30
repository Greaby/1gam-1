extends TextureButton

func get_drag_data(pos):
	var server = load("res://server/assets/streamer.png")
	set_drag_preview(server)
	return "streamer"