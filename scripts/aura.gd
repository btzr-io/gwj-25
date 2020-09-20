extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var active = false
export var aura_scale = 1.1
export var follow_mouse = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if active:
		$SpriteMask.mask_scale = aura_scale
	else:
	   $SpriteMask.mask_scale = 0.0
	
	$SpriteMask.follow_mouse = follow_mouse

		
func show():
	active = true
	var current_scale = $SpriteMask.mask_scale
	if current_scale < 1.0:
		$Tween.stop_all()
		$Tween.interpolate_property($SpriteMask, 'mask_scale', current_scale, aura_scale, 0.8, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		$Tween.start()

func update_mask_position(target_position):
	$SpriteMask.mask_position = target_position
	
	
func hide():
	active = false
	var current_scale = $SpriteMask.mask_scale
	if current_scale >= 0.0:
		$Tween.stop_all()
		$Tween.interpolate_property($SpriteMask, 'mask_scale', current_scale, 0, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$Tween.start()
