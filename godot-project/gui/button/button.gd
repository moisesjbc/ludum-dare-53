extends Button


func _on_button_pressed():
	get_tree().get_root().get_node("SFX").play_button_pressed_sound()
