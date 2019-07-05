extends Node2D

func _ready():
	$AnimationPlayer.current_animation = "Movement"
	$AnimationPlayer.play()