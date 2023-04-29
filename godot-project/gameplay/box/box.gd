extends KinematicBody2D


var type
var velocity = Vector2.ZERO
var near_magnets = []
var current_delivery_zone = null


func set_type(new_type, colors):
	type = new_type
	$sprite.modulate = colors[type]


func _process(delta):
	var velocity = Vector2.ZERO

	for near_magnet in near_magnets:
		var multiplier = 1
		if type == near_magnet.type():
			multiplier = -1
		velocity += (near_magnet.global_position - global_position).normalized() * multiplier * (near_magnet.radius() - global_position.distance_to(near_magnet.global_position))
		
	var collision = move_and_collide(velocity * delta)
	if collision and collision.collider.get_node_or_null("magnet") and collision.collider.get_node("magnet").type() != type:
		collision.collider.get_node("magnet").attach(self)
