extends KinematicBody2D


#vars:
var motion : Vector2 = Vector2()
var starting_point : Vector2 
var point : Vector2

#vars_bool:
var wait_than_go : bool = false
var r : bool = false
var go : bool = false

#exported_vars:
export var speed : int = 200
export var end_point : Vector2
export var wait_time : float = 0.5

#var_timer:
var were : String = ''

#funcs:

func _ready():
	$wait_time.wait_time = wait_time
	starting_point = global_position
	end_point += starting_point
	global_position = starting_point




func _physics_process(delta):
	
	if go == true:
		go_to(point)
	
	else:
		motion = Vector2.ZERO
	
	#move_and_slide:
	move_and_slide(motion)
	
	
	#stop:
	if r == true:
		go = false
		wait_than_go = true
		$wait_time.start()
		r = false
	
	
	#move_to_point:
	if wait_than_go == false:
		if starting_point.x == end_point.x:
			if starting_point.y > end_point.y:
				if global_position.y <= end_point.y:
					r = true
					were = 'start_point'
				elif global_position.y >= starting_point.y:
					r = true
					were = 'end_point'
			
			else:
				if global_position.y >= end_point.y:
					r = true
					were = 'start_point'
				elif global_position.y <= starting_point.y:
					r = true
					were = 'end_point'
		
		else:
			
			if starting_point.x < end_point.x:
				if global_position.x >= end_point.x:
					r = true
					were = 'start_point'
				
				elif global_position.x <= starting_point.x:
					r = true
					were = 'end_point'
			
			else:
				if global_position.x <= end_point.x:
					r = true
					were = 'start_point'
				
				elif global_position.x >= starting_point.x:
					r = true
					were = 'end_point'






func go_to(point):
	
	var rotate = (point - global_position).normalized() 
	motion = rotate * speed


func _on_wait_time_timeout():
	wait_than_go = false
	
	if were == 'start_point':
		point = starting_point
		go = true
	
	elif were == 'end_point':
		point = end_point
		go = true
