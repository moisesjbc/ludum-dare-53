extends KinematicBody2D


var color
var velocity = Vector2.ZERO
var near_magnets = []
var colors = [
	Color.orange,
	Color.blue,
	Color.green,
	Color.aliceblue
]


func _ready():
	randomize()
	set_color(colors[randi() % len(colors)])


func set_color(new_color):
	color = new_color
	$sprite.modulate = color


func _process(delta):
	var velocity = Vector2.ZERO

	for near_magnet in near_magnets:
		var multiplier = 1
		if color == near_magnet.color():
			multiplier = -1
		velocity += (near_magnet.global_position - global_position).normalized() * multiplier * (near_magnet.radius() - global_position.distance_to(near_magnet.global_position))
		
	var collision = move_and_collide(velocity * delta)
	if collision and collision.collider.get_node_or_null("magnet") and collision.collider.get_node("magnet").color() != color:
		collision.collider.get_node("magnet").attach(self)
