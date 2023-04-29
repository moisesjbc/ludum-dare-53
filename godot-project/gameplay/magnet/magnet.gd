extends Node2D


func _ready():
	global_position = get_parent().global_position


func _on_magnet_body_entered(body):
	if body.is_in_group("boxes"):
		body.near_magnets.append(self)


func _on_magnet_body_exited(body):
	if body.is_in_group("boxes"):
		body.near_magnets.erase(self)


func radius():
	return $influence_area/collision_shape.shape.radius
	

func type():
	return get_parent().type
	

func attach(object):
	print("Attaching ", object.name, " to ", name)
	var object_position = object.global_position
	var object_rotation = object.global_rotation
	object.get_parent().remove_child(object)
	$attachments.add_child(object)
	object.set_process(false)
	object.set_collision_mask_bit(0, false)
	object.global_position = object_position
	object.global_rotation = object_rotation
	
	var magnet_scene = load("res://gameplay/magnet/magnet.tscn")
	object.add_child(magnet_scene.instance())
	

func detach(object):
	print("Detaching ", object.name, " from ", get_parent().name)
	var object_position = object.global_position
	var object_rotation = object.global_rotation
	$attachments.remove_child(object)
	object.box_generator.get_node("boxes").add_child(object)
	object.set_process(true)
	object.set_collision_mask_bit(0, true)
	object.global_position = object_position
	object.global_rotation = object_rotation
	print("Position of ", object.name, " : ", object.global_position)
	var object_magnet = object.get_node_or_null("magnet")
	if object_magnet:
		object_magnet.remove()


func detach_all():
	for attachment in $attachments.get_children():
		detach(attachment)


func remove():
	detach_all()
	queue_free()
