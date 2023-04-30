extends Node2D

onready var box_scene = preload("res://gameplay/box/box.tscn")
var colors

export (float) var min_spawn_time = 1
export (float) var max_spawn_time = 2

export (float) var horizontal_box_probability = 0.2


func reset(colors):
	start_spawn_timer()
	self.colors = colors

func start_spawn_timer():
	var random_time = min_spawn_time + randf() * (max_spawn_time - min_spawn_time)
	$respawn_timer.start(random_time)


func _on_respawn_timer_timeout():
	for i in range(0, 2):
		spawn_box()
	start_spawn_timer()


func spawn_box():
	var new_box = box_scene.instance()
	$boxes.add_child(new_box)
	
	var respawn_position = null
	var box_direction = Vector2.ZERO
	
	if randf() <= horizontal_box_probability:
		respawn_position = $respawn_positions/left_respawn_position
		var horizontal_velocity = 1
		if randi() % 2:
			respawn_position = $respawn_positions/right_respawn_position
			horizontal_velocity = -1
			
		new_box.global_position = Vector2(
			respawn_position.global_position.x,
			respawn_position.global_position.y + (-200 + randi() % 400)
		)
		box_direction = Vector2(horizontal_velocity, 0)
		box_direction.y = (-50 + randi() % 100) * 0.01
	else:
		respawn_position = $respawn_positions/top_respawn_position
		new_box.global_position = Vector2(
			respawn_position.global_position.x + (-400 + randi() % 800),
			respawn_position.global_position.y
		)
		box_direction = Vector2(0, 1)
		box_direction.x = (-50 + randi() % 100) * 0.01
	
	new_box.colors = colors
	new_box.set_velocity(box_direction.normalized())
	new_box.set_type(randi() % 2)
	
	
	
	
