extends Sprite

func _on_Area2D_body_entered(body):
	if Globals.total_gears >= 4:
		$AnimationPlayer.current_animation = "Escape"
		$AnimationPlayer.play()
		Globals.escape = true

