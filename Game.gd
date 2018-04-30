extends Node

var time = 0
export (float) var money = 1000
var viewers = 0

func _ready():
	for server in $Servers.get_children():
		server.connect("spend_money", self, "_spend_money")
	

func _process(delta):
	$Money.text = str(money)
	update_viewers()

func _spend_money(amount):
	money -= amount
	
func update_viewers():
	viewers = 0
	for server in $Servers.get_children():
		viewers += server.viewers
		
	$Viewers.text = str(viewers)

func _on_MoneyTimer_timeout():
	money += viewers
