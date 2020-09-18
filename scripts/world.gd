extends Node

var playerHasKey: bool = false
var playerInitialPosition: Vector2


func _ready():
	$Key.connect("body_entered", self, "_on_key_body_entered")
	$Portal.connect("body_entered", self, "_on_portal_body_entered")
	$Player.connect("player_die", self, "_on_player_die")

	playerInitialPosition = $Player.position
	pass

func _on_key_body_entered(body):
	if body == $Player:
		playerHasKey = true
		$Key.visible = false
		$Key.disconnect("body_entered", self, "_on_key_body_entered")
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
