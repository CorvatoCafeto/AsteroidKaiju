extends Area2D

class_name Gear

var taken = false

func _on_Gear_body_entered(body):
		if not taken and body is Astronaut:
			$AnimationPlayer.play("Taken")
			taken = true
			Globals.total_gears += 1 
