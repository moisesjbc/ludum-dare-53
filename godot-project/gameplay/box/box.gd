extends KinematicBody2D


var type
var velocity = Vector2.ZERO
var near_magnets = []
var current_delivery_zone = null
var box_generator
var speed = 400
var colors


func set_type(new_type):
	type = new_type
	$blue_box_sprite.visible = type == 0
	$green_box_sprite.visible = type != 0
	for box in $boxes.get_children():
		box.set_type(new_type)


func set_velocity(new_velocity):
	velocity = new_velocity


func _process(delta):
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		print("collision between ", name, " and ", collision.collider.name)
		var player = get_tree().get_root().get_node("main/player")
		if type == collision.collider.type:
			player.add_box(self)
		else:
			queue_free()
			player.destroy()


func deliver(is_correct):
	var magnet = get_node_or_null("magnet")
	if magnet:
		magnet.remove()

	if is_correct:
		$score_label.text = "+10"
		$animation_player.play("correct_delivery")
	else:
		$score_label.text = "-10"
		$animation_player.play("wrong_delivery")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "correct_delivery" or anim_name == "wrong_delivery":
		queue_free()
