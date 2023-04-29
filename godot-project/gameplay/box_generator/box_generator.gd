extends Node2D

onready var box_scene = preload("res://gameplay/box/box.tscn")
var colors


func reset(colors):
	$respawn_timer.start()
	self.colors = colors



func _on_respawn_timer_timeout():
	spawn_box()


func spawn_box():
	var new_box = box_scene.instance()
	new_box.global_position = Vector2(
		200 + randi() % 800,
		200 + randi() % 600
	)
	$boxes.add_child(new_box)
	new_box.set_type(randi() % 2, colors, self)
