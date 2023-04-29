extends KinematicBody2D


var color
var velocity = Vector2.ZERO
var near_magnets = []


func _ready():
	set_color(Color.orange)
	
	
func set_color(new_color):
	color = new_color
	$sprite.modulate = color


func _process(delta):
	var velocity = Vector2.ZERO

	for near_magnet in near_magnets:
		velocity += (near_magnet.global_position - global_position).normalized() * (near_magnet.radius() - global_position.distance_to(near_magnet.global_position))
		
	move_and_collide(velocity * delta)
