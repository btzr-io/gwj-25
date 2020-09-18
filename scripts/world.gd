extends Node

var playerHasKey: bool = false
var playerInitialPosition: Vector2

func _ready():
	GM.init_level()
	$Light_world/Key.connect("body_entered", self, "_on_key_body_entered")
	$Light_world/Portal.connect("body_entered", self, "_on_portal_body_entered")
	$Player.connect("player_die", self, "_on_player_die")
	playerInitialPosition = $Player.position
	

func _on_key_body_entered(body):
	if body == $Player:
		playerHasKey = true
		$Light_world/Key.visible = false
		$Light_world/Key.disconnect("body_entered", self, "_on_key_body_entered")
	pass
	
func _on_portal_body_entered(body):
	if playerHasKey:
		print('level finished !')
	
	pass

func _on_player_die():
	# Delay one second
	yield(get_tree().create_timer(1), "timeout")
	$Player.respawn(playerInitialPosition)
	pass
