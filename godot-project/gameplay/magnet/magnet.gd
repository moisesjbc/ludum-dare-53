extends Node2D


func _on_magnet_body_entered(body):
	if body.is_in_group("boxes"):
		body.near_magnets.append(self)


func _on_magnet_body_exited(body):
	if body.is_in_group("boxes"):
		body.near_magnets.erase(self)


func radius():
	return $influence_area/collision_shape.shape.radius
	

func attach(object):
	var object_position = object.global_position
	object.get_parent().remove_child(object)
	$attachments.add_child(object)
	object.set_process(false)
	object.set_collision_mask_bit(0, false)
	object.global_position = object_position
	
	var magnet_scene = load("res://gameplay/magnet/magnet.tscn")
	object.add_child(magnet_scene.instance())
