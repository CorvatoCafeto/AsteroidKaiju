extends WorldEnvironment

func _on_Timer_timeout():
	$AnimationPlayer.current_animation = "FadeIn"
	$AnimationPlayer.play()