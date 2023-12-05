extends CharacterBody2D

var jumpImpulse = 6.5 * 60
var gravityImpulse: = 8.0 * 60
var speed_h = 3.0 * 60 


func _physics_process(delta):
	if Input.is_key_pressed(KEY_A):
		position.x -= speed_h * delta
	elif Input.is_key_pressed(KEY_D):
		position.x += speed_h * delta
	#position.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.y += gravityImpulse * delta
	
	if is_on_floor():
		velocity.y = -jumpImpulse
		
	
	velocity.x *= speed_h
	
	move_and_slide()
