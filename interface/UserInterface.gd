extends CanvasLayer

onready var quantity = $Control/GearsPanel/Quantity
onready var health = $Control/HealthPanel/Percentage
onready var fuel = $Control/ProgressBar

func _ready():
	fuel.value = Globals.jetpack_fuel
	fuel.max_value = Globals.jetpack_fuel
	fuel.step = Globals.jetpack_step
	$Control/HBoxContainer.visible = false

func _process(delta):
	update_gears()
	update_health()
	update_fuel()
	
func update_gears():
	match Globals.total_gears:
		0:
			quantity.text = "0/4"
		1:
			quantity.text = "1/4"
		2:
			quantity.text = "2/4"
		3:
			quantity.text = "3/4"
		4:
			quantity.text = "4/4"
			 
func update_health():
	match Globals.astronaut_health:
		0:
			health.text = "000%"
			$Control/HBoxContainer.visible = true
		1:
			health.text = "025%"
		2:
			health.text = "050%"
		3:
			health.text = "075%"
		4:
			health.text = "100%"
			
func update_fuel():
	fuel.value = Globals.jetpack_fuel

func _on_Retry_pressed():
	get_tree().change_scene("res://scenes/AnotherSpace.tscn")
	Globals.death = false
	Globals.astronaut_health = 4

func _on_Exit_pressed():
	get_tree().quit()