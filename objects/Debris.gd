extends RigidBody2D

func _on_Area2D_body_entered(body):
		if body is Astronaut:
			Globals.astronaut_health -= 1
			Globals.hit = true
			print("hit")