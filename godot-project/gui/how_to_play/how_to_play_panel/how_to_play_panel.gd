extends Panel


signal back_button_pressed
signal next_button_pressed

var step_index


func set_text(step_index, text):
	self.step_index = step_index
	$margin_container/vbox_container/instructions.text = text


func _on_back_button_pressed():
	emit_signal("back_button_pressed")


func _on_next_button_pressed():
	emit_signal("next_button_pressed")
