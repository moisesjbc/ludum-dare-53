extends KinematicBody2D

signal player_destroyed
signal player_delivered(n_boxes)
export (int) var speed = 500
var type = 0
var colors
var on_cooldown = false


func _ready():
	set_physics_process(get_parent().name != "how_to_play")


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
	if not on_cooldown:
		box.set_process(false)

		var box_global_position = box.global_position
		box.get_parent().remove_child(box)
		$boxes.add_child(box)
		
		# Disable collisions against player so box does not stop it from moving.
		box.set_collision_mask_bit(0, false)
		# Make box collidable with wall
		box.set_collision_mask_bit(3, true)
		box.set_collision_layer(1)
		
		box.global_position = box_global_position

func remove_all_boxes():
	for box in $boxes.get_children():
		box.destroy()


func destroy():
	if not on_cooldown:
		start_cooldown()
		$explosion_sound.play()
		$blue_sprite.visible = false
		$green_sprite.visible = false
		for box in $boxes.get_children():
			box.destroy()
		$explosion.start(self, "destroy_player")
	

func destroy_player():
	emit_signal("player_destroyed")

	
func deliver_all_boxes():
	if not on_cooldown:
		start_cooldown()
		$delivery_sound.play()
		emit_signal("player_delivered", $boxes.get_child_count())
		for box in $boxes.get_children():
			box.deliver()


func _input(event):
	if not on_cooldown and event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		if type == 0:
			set_type(1)
		else:
			set_type(0)


func start_cooldown():
	on_cooldown = true
	$cooldown_timer.start(0.5)


func _on_cooldown_timer_timeout():
	on_cooldown = false
