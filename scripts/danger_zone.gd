extends Area2D

const Player = preload("res://scripts/player.gd")

func _on_DangerZone_body_entered(body):
	if body is Player:
		body.die()
	pass # Replace with function body.
