extends Control


func _on_credits_meta_clicked(meta):
	OS.shell_open(meta)


func _on_main_menu_button_pressed():
	get_tree().change_scene("res://gui/main_menu/main_menu.tscn")
