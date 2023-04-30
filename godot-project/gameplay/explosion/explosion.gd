extends CPUParticles2D


var callback_object
var callback_name


func start(callback_object, callback_name):
	self.callback_object = callback_object
	self.callback_name = callback_name

	emitting = true
	$timer.start(0.5)


func _on_timer_timeout():
	if callback_object:
		callback_object.call(callback_name)
