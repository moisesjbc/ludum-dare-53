extends Node2D

var current_step_index = 0


func _ready():
	set_step_index(0)


func _on_main_menu_button_pressed():
	get_tree().change_scene("res://gui/main_menu/main_menu.tscn")


func set_step_index(step_index):
	$states.get_child(current_step_index).visible = false
	
	current_step_index = int(step_index)
	$states.get_child(current_step_index).visible = true
	$how_to_play_panel.set_text(current_step_index, $states.get_child(current_step_index).text)
	var panel_position = $states.get_child(current_step_index).get_node_or_null("position")
	if panel_position:
		$how_to_play_panel.rect_global_position = panel_position.global_position


func _on_how_to_play_panel_back_button_pressed():
	if current_step_index > 0:
		set_step_index(current_step_index - 1)
	else:
		get_tree().change_scene("res://gui/main_menu/main_menu.tscn")


func _on_how_to_play_panel_next_button_pressed():
	if current_step_index < ($states.get_child_count() - 1):
		set_step_index(current_step_index + 1)
	else:
		get_tree().change_scene("res://gui/main_menu/main_menu.tscn")
