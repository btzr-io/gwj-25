extends Node


#vars:
var wait_anim : bool = false
var once : bool = false
var go_to_scene : String

#exported_vars:
export var starting_level_link : String

func _ready():
	
	#fade_in_animation:
	$buttons/pos.modulate = Color(1, 1, 1, 0)
	$buttons/pos.global_position.x = 108.041
	$fade.modulate = Color(0, 0, 0, 1)
	$anim.play("fade_in")


#buttons_pressed:
func _on_start_pressed():
	
	if wait_anim == true:
		go_to_scene = 'start'
		$anim.play("fade_out")
		wait_anim = false


func _on_exit_pressed():
	
	if wait_anim == true:
		go_to_scene = 'exit'
		$anim.play("fade_out")
		wait_anim = false


func _on_anim_animation_finished(anim_name):
	
	if anim_name == 'fade_in':
		wait_anim = true
	
	elif anim_name == 'fade_out':
		
		if go_to_scene == 'start':
			get_tree().change_scene(starting_level_link)
		
		elif go_to_scene == 'exit':
			get_tree().quit()
