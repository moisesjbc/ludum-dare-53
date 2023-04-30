extends Panel


var score = 0


func _ready():
	set_score(0)


func set_score(new_score):
	score = new_score
	$label.text = str(score)


func add_score(score_delta):
	set_score(score + score_delta)
