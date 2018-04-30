extends Node

var viewer = 0
var stream_left = 0
var bandwidth = 0


func _ready():
	viewer = randi() % 550 + 50
	stream_left = randi() % 20 + 10
	bandwidth = randi() % 9 + 1
