extends Node2D

var colors = [
	Color.blue,
	Color.green
]


func _ready():
	reset()
	
	
func reset():
	randomize()
	#$delivery_zone.set_type(0, colors)
	#$delivery_zone2.set_type(1, colors)
	
	$player.reset(colors)
	$box_generator.reset(colors)
