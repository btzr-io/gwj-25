extends Node

var current_level = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_level(level):
	get_tree().change_scene(level)

func exit():
	get_tree().quit()
