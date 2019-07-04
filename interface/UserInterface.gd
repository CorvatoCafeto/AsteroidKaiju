extends CanvasLayer

onready var quantity = $Control/GearsPanel/Quantity
onready var health = $Control/HealthPanel/Percentage

func _process(delta):
	update_gears()
	update_health()
	
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
		1:
			health.text = "025%"
		2:
			health.text = "050%"
		3:
			health.text = "075%"
		4:
			health.text = "100%"