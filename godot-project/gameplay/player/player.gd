extends KinematicBody2D


export (int) var speed = 500
var magnet_working = false


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
	
	look_at(get_global_mouse_position())
