extends Node2D

var colors = [
	Color.blue,
	Color.green
]


func _ready():
	reset()
	
	
func reset():
	randomize()
	for box in $boxes.get_children():
		box.set_type(randi() % len(colors), colors)

	$delivery_zone.set_type(0, colors)
	$delivery_zone2.set_type(1, colors)
