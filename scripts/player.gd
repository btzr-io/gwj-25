extends KinematicBody2D

signal player_die

#CONSTANTS
const UP = Vector2(0,-1)
const GRAVITY = 30
const ACCELERATION = 150
const MAX_SPEED = 600
const JUMP_HEIGHT = -900
const AURA = preload("res://scenes/aura.tscn")

const COLLISION_LAYER = {
	# Layers: 4
	"dark":  4,
	# Layers: 2,
	"light": 1
}

const COLLISION_MASK = {
	# Layers: 4
	"dark":   8,
	# Layers: 2,
	"light":  2
}

const MAX_HOLD_TIME = 0.2

#VARIABLES
var aura = null
var state = "light"
var friction = false
var motion = Vector2()
var jump_count = 1
var jumped = false

var hold_time = 0


func _ready():
	create_aura()

# Toggle dark / light mode
func _process(delta):
	if state != "dead" and state != "sleep":
		if Input.is_action_pressed("player_toggle"):
			hold_time += delta
			if state != "dark" and hold_time > MAX_HOLD_TIME:
				dark_mode()
		elif Input.is_action_just_released("player_toggle"):
			hold_time = 0
			if state == "dark": 
				light_mode()

func dark_mode():
	if !aura.active:
		if $portalOpenAudioPlayer.playing:
			$portalOpenAudioPlayer.stop()
		$portalOpenAudioPlayer.play()
	if !$darkMatterAudioPlayer.playing:
		$darkMatterAudioPlayer.play()

	$Sprite.modulate = Color(1, 0, 0)
	aura.show()
	state = "dark"	
	yield(get_tree().create_timer(0.3), "timeout")
	if state == "dark":
		update_collisions(state)
		
func light_mode():
	if aura.active:
		$portalCloseAudioPlayer.play()
	$darkMatterAudioPlayer.stop()
	$Sprite.modulate = Color(1, 1, 1)
	aura.hide()
	state = "light"	
	yield(get_tree().create_timer(0.3), "timeout")
	if state == "light":
		update_collisions(state)
	# Hide mask effect and change sprites....

func create_aura():
	aura = AURA.instance()
	print_debug(GM.canvas_layer)
	var canvas_layer = GM.find_canvas_layer()
	if canvas_layer != null:
		canvas_layer.call_deferred("add_child", aura)

func update_collisions(mode):
	if mode == "light" or mode =="dark":
		set_deferred("collision_mask",COLLISION_MASK[mode])
		set_deferred("collision_layer",COLLISION_LAYER[mode])

#MOVEMENTS FUNCTION
func _physics_process(delta):
	motion.y += GRAVITY
	
	aura.update_mask_position(position)
	
	if state != "dead" and state != "sleep":
		movement()
			
	else:
		friction = true
	
	#Determines if the player is jumping
	if $Ground.is_colliding():
		if jumped:
			$landingAudioPlayer.play()
			jumped = false
		jump_count = 1
#		if Input.is_action_just_pressed("player_jump"):
#			motion.y = JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		motion.x = lerp(motion.x, 0, 0.05)
	
	#Updates the values of the motion vector
	#motion = move_and_slide(motion, UP, false, 4, 0.785398, false)
	motion = move_and_slide(motion, UP)
	if !$Ground.is_colliding():
		jumped = true


func movement():
	#Sets velocitiy
	if Input.is_action_pressed("player_move_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
#		$Sprite.play("run")
		
	elif Input.is_action_pressed("player_move_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
#		$Sprite.play("run")
		
	if Input.is_action_just_pressed("player_jump"):
		if jump_count < 2:
			$jumpAudioPlayer.play()
			motion.y = JUMP_HEIGHT
			jump_count +=1
	if Input.is_action_pressed("player_jump") && $Ground.is_colliding():
			if jump_count == 1:
				$jumpAudioPlayer.play()
				motion.y = JUMP_HEIGHT
				jump_count +=1
		
	if Input.is_action_just_released("player_jump") and motion.y < -450:
		motion.y = -450
	
#	elif not is_on_floor():
##		$Sprite.play("jump")
	
	else:
#		$Sprite.play("idle")
		friction = true

func respawn(new_position):
	position = new_position
	light_mode()

func die():
	light_mode()
	state = "dead"
	#$Sprite.play("dead")
	$damageAudioPlayer.play()
	$Camera2D.add_trauma(0.8)
	emit_signal("player_die")
	pass
