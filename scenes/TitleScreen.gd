extends Control

var scene_control

func _ready():
	OS.window_fullscreen = false

func _on_StartButton_pressed():
	scene_control = get_tree().change_scene("res://scenes/AnotherSpace.tscn")
	

func _on_FullscreenButton_pressed():
	if OS.window_fullscreen == false:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false
	pass # Replace with function body.

func _on_CreditsButton_pressed():
	pass # Replace with function body.

func _on_ExitButton_pressed():
	get_tree().quit()
