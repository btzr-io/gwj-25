extends Node

const Collision_Layers = {
	"Walls": 3,
	"Hero": 7,
	"Enemies": 8,
}

var current_level = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_level(level):
	get_tree().change_scene(level)

func exit():
	get_tree().quit()
