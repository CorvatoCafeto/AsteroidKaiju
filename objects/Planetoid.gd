extends Area2D

export (Color) var atmosphere = Color(.37, .62, .9, .15)

const GRAVITY = 4000

onready var gravityCenter = get_node("GravityCenter")
var gravityEffectField = GRAVITY / 12

func _ready():
	update()
	
func _draw():
	draw_circle(gravityCenter.position, gravityEffectField, atmosphere)
	
func is_in_gravity_field(pos):
	return gravityCenter.global_position.distance_to(pos) <= gravityEffectField