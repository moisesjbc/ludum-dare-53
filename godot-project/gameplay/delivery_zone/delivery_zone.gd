extends Area2D

var type = 0


func set_type(new_type, colors):
	type = new_type
	$color_rect.color = colors[type]


func _on_delivery_zone_body_entered(body):
	if body.is_in_group("boxes"):
		body.queue_free()
