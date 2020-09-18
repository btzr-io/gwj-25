extends Node

var current_level = null
var current_scene = null
var canvas_layer = null
# Called when the node enters the scene tree for the first time.
func _ready():
	init_level()
	pass # Replace with function body.

func load_level(level):
	get_tree().change_scene(level)

func exit():
	get_tree().quit()


func init_level():
	current_scene = get_tree().current_scene
	
	if current_scene:
		canvas_layer = current_scene.get_node_or_null('CanvasLayer')
		print_debug(canvas_layer)


func find_canvas_layer():
	init_level()
	return canvas_layer
