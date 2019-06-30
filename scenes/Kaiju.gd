extends "res://scenes/Movement.gd"

func apply_force(state):
	if(Input.is_action_pressed("ui_left")):
		directional_force += DIRECTION.LEFT
	if(Input.is_action_pressed("ui_right")):
		directional_force += DIRECTION.RIGHT

func _on_GroundCheck_body_entered(body):
	pass # Replace with function body.	
	
func _on_GroundCheck_body_exited(body):
	pass # Replace with function body.
