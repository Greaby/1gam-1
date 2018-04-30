extends TextureButton

func get_drag_data(pos):
	var server = load("res://server/ServerPreview.tscn")
	set_drag_preview(server.instance())
	return "server"