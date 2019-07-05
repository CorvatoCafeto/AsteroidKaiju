extends StaticBody2D

export (Color) var atmosphere = Color(.37, .62, .9, .15)

#const GRAVITY = 200
export var GRAVITY = 200

onready var gravityCenter = get_node("GravityCenter")
var gravityEffectField = GRAVITY

func _ready():
	update()
	
func _draw():
	draw_circle(gravityCenter.position, gravityEffectField, atmosphere)
	
func is_in_gravity_field(pos):
	return gravityCenter.global_position.distance_to(pos) <= gravityEffectField