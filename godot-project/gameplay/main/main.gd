extends Node2D

export (int) var score_per_box = 10

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


func _on_player_player_delivered(n_boxes):
	$gui/score.add_score(n_boxes * score_per_box)
