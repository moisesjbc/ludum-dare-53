extends Node2D

var colors = [
	Color.blue,
	Color.green
]


func _ready():
	reset()
	
	
func reset():
	randomize()
	
	$player.reset(colors)
	$box_generator.reset(colors)
	$delivery_zone.reset($player)


func _on_player_player_destroyed():
	$gui/game_over.start()
