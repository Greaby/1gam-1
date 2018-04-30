extends TextureButton

func get_drag_data(pos):
	var preview = load("res://server/UpgradePreview.tscn")
	set_drag_preview(preview.instance())
	return "upgrade"