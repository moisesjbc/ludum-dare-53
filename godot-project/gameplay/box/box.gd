extends KinematicBody2D


var type
var velocity = Vector2.ZERO
var near_magnets = []
var current_delivery_zone = null
var box_generator
var speed = 400
var colors
var rotation_velocity = 0

func set_type(new_type):
	type = new_type
	$blue_box_sprite.visible = type == 0
	$green_box_sprite.visible = type != 0
	for box in $boxes.get_children():
		box.set_type(new_type)


func set_velocity(new_velocity):
	velocity = new_velocity
	var rotation_multiplier = 1
	if randi() % 2:
		rotation_multiplier = -1
	rotation_velocity = rotation_multiplier * (2 + randi() % 4)
	


func _process(delta):
	rotate(rotation_velocity * delta)
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		var player = get_tree().get_root().get_node("main/player")
		if type == collision.collider.type:
			player.add_box(self)
		else:
			queue_free()
			player.destroy()
	elif global_position.x < -500 || global_position.x > (get_viewport_rect().size.x + 500) || global_position.y < -500 || global_position.y > (get_viewport_rect().size.y + 500):
		queue_free()


func deliver():
	$collision_shape.disabled = true
	set_collision_mask(0)
	$blue_box_sprite.visible = false
	$green_box_sprite.visible = false
	$delivery_effect.start(self, "queue_free")


func destroy():
	set_collision_mask(0)
	$collision_shape.disabled = true
	$blue_box_sprite.visible = false
	$green_box_sprite.visible = false
	$explosion.start(null, null)
