extends Label

var seconds_elapsed = 0


func _ready():
	set_time(0)


func set_time(new_seconds_elapsed):
	self.seconds_elapsed = new_seconds_elapsed
	text = "%02d:%02d" % [self.seconds_elapsed / 60, self.seconds_elapsed % 60]


func _on_timer_timeout():
	set_time(seconds_elapsed + 1)
