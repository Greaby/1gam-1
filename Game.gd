extends Node

var time = 0
export (float) var money = 1000
var objective = 500
export (float) var objective_grow

var viewers = 0

func _ready():
	for server in $Servers.get_children():
		server.connect("spend_money", self, "_spend_money")
		
	$Clock.connect("day_end", self, "_day_end")
	

func _process(delta):
	$Money.text = str(money) + "$"
	$Objective.text = str(objective) + "$"
	update_viewers()

func _spend_money(amount):
	money -= amount

func update_viewers():
	viewers = 0
	for server in $Servers.get_children():
		viewers += server.viewers
		
	$Viewers.text = str(viewers) + " viewers"

func _on_MoneyTimer_timeout():
	money += viewers
	
func _day_end():
	money -= objective
	objective += int(objective * objective_grow)
	
	if(money < 0):
		get_tree().change_scene("res://GameOver.tscn")

