extends KinematicBody2D

signal player_destroyed
signal player_delivered(n_boxes)
export (int) var speed = 500
var type = 0
var colors


func reset(colors):
	self.colors = colors
	set_type(0)


func _physics_process(delta):
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1

	move_and_collide(speed * velocity * delta)


func set_type(new_type):
	type = new_type
	$blue_sprite.visible = type == 0
	$green_sprite.visible = type != 0
	for box in $boxes.get_children():
		box.set_type(new_type)


func add_box(box):
	print("Adding ", box.name, " as child to player")
	box.set_process(false)
	# Disable collisions against player so box does not stop it from moving.
	box.set_collision_mask_bit(0, false)
	box.set_collision_layer(1)
	
	var box_global_position = box.global_position
	box.get_parent().remove_child(box)
	$boxes.add_child(box)
	box.global_position = box_global_position

func remove_all_boxes():
	for box in $boxes.get_children():
		box.queue_free()
		
func destroy():
	remove_all_boxes()
	emit_signal("player_destroyed")
	
func deliver_all_boxes():
	emit_signal("player_delivered", $boxes.get_child_count())
	remove_all_boxes()

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		if type == 0:
			set_type(1)
		else:
			set_type(0)
