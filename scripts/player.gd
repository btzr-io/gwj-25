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

#VARIABLES
var aura = null
var state = "light"
var friction = false
var motion = Vector2()
var jump_count = 1
var jumped = false

func _ready():
	create_aura()

# Toggle dark / light mode
func _process(delta):
	if state != "dead" and state != "sleep":
		if Input.is_action_pressed("player_toggle") and state != "dark":
			dark_mode()
		if Input.is_action_just_released("player_toggle") and state == "dark":
			light_mode()

func dark_mode():
	$portalOpenAudioPlayer.play()
	$darkMatterAudioPlayer.play()
	state = "dark"
	update_collisions(state)
	$Sprite.modulate = Color(1, 0, 0)
	aura.show()
	# Show mask effect and change sprites....

func light_mode():
	if aura.active:
		$portalCloseAudioPlayer.play()
		$darkMatterAudioPlayer.stop()
	state = "light"
	update_collisions(state)
	$Sprite.modulate = Color(1, 1, 1)
	aura.hide()
	# Hide mask effect and change sprites....

func create_aura():
	aura = AURA.instance()
	print_debug(GM.canvas_layer)
	var canvas_layer = GM.find_canvas_layer()
	if canvas_layer != null:
		canvas_layer.call_deferred("add_child", aura)

func update_collisions(mode):
	if mode == "light" or mode =="dark":
		set_collision_mask(COLLISION_MASK[mode])
		set_collision_layer(COLLISION_LAYER[mode])

#MOVEMENTS FUNCTION
func _physics_process(delta):
	motion.y += GRAVITY
	
	aura.update_mask_position(position)
	
	if state != "dead" and state != "sleep":
		movement()
			
	else:
		friction = true
	
	#Determines if the player is jumping
	if is_on_floor():
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
	motion = move_and_slide(motion, UP)
	if motion.y > 0:
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
	
	$Camera2D.add_trauma(0.8)
	emit_signal("player_die")
	pass
