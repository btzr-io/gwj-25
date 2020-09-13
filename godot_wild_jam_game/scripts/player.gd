extends KinematicBody2D


#vars:

#phy_vars:
var motion : Vector2 = Vector2()
var up : Vector2 = Vector2(0, -1)
var speed : int = 400
var gravity : int = 10
var jump : int = -400
var acc : int = 15
var max_acc : int = 500

#exported_vars:
export var with_acc : bool = false

#funcs:

#phy_func:
func _physics_process(delta):
	
	
	#move_and_slide:
	motion = move_and_slide(motion, up)
	
	#gravity:
	motion.y += gravity
	
	#calling_movment_func:
	move()


#move_func:
func move():
	
	
	#movement:
	
	#right:
	if Input.is_action_pressed("ui_right"):
		
		#with acceleration or not:
		if with_acc == true:
			motion.x += acc
			if motion.x >= max_acc:
				motion.x = max_acc
		
		else:
			motion.x = speed
	
	#left:
	elif Input.is_action_pressed("ui_left"):
		
		#with acceleration or not:
		if with_acc == true:
			motion.x -= acc
			if motion.x <= -max_acc:
				motion.x = -max_acc
		
		else:
			motion.x = -speed
	
	#idle:
	else:
		
		#with acceleration or not:
		if with_acc == true:
			motion.x = lerp(motion.x, 0, 0.1)
		
		else:
			motion.x = 0
