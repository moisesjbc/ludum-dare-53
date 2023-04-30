extends Control


func start():
	get_tree().paused = true
	visible = true


func _on_restart_button_pressed():
	get_tree().paused = false
	visible = false
	get_tree().reload_current_scene()

