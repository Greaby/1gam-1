extends Position2D


func _ready():
	$"..".connect("time_changed", self, '_on_Parent_time_changed')

func _on_Parent_time_changed(angle):
	rotation = angle