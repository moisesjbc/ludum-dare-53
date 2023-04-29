extends KinematicBody2D


export (int) var speed = 500
var type = -1


func _physics_process(delta):
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1
		
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1

	move_and_collide(speed * velocity * delta)


func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		if get_node_or_null("magnet"):
			print("Removing magnet from player")
			get_node("magnet").remove()
		else:
			print("Addign magnet to player")
			var magnet_scene = load("res://gameplay/magnet/magnet.tscn")
			add_child(magnet_scene.instance())
