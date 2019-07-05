extends Sprite

func _on_Area2D_body_entered(body):
	$AnimationPlayer.current_animation = "Escape"
	$AnimationPlayer.play()
	Globals.escape = true

