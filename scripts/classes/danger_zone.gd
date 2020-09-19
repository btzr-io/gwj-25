extends Area2D
class_name DangerZone

onready var signal_connection = self.connect("body_entered", self, "handle_entered");

func handle_entered(body):
	if body.is_in_group("character"):
		$hitAudioPlayer.play()
		body.die()
