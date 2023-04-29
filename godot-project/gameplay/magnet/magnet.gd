extends Area2D


func _on_magnet_body_entered(body):
	if body.is_in_group("boxes"):
		body.near_magnets.append(self)


func _on_magnet_body_exited(body):
	if body.is_in_group("boxes"):
		body.near_magnets.erase(self)


func radius():
	return $collision_shape.shape.radius
