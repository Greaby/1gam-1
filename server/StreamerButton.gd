extends TextureButton

func get_drag_data(pos):
	var streamer = load("res://server/StreamerPreview.tscn")
	set_drag_preview(streamer.instance())
	return "streamer"