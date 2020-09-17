extends Node

var playerHasKey: bool = false


func _ready():
	get_node("key").connect("body_entered", self, "_on_key_body_entered")
	get_node("portal").connect("body_entered", self, "_on_portal_body_entered")
	pass

func _on_key_body_entered(body):
	if body == $Player:
		playerHasKey = true
		$key.visible = false
		get_node("key").disconnect("body_entered", self, "_on_key_body_entered")
	pass
	
func _on_portal_body_entered(body):
	if playerHasKey:
		print('level finished !')
	
	pass
