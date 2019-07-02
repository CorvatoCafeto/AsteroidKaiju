extends KinematicBody2D

var closestPlanet

var direction = 1

var speed = Vector2()
var velocity = Vector2()

const MAX_SPEED = 10000
const JUMP_FORCE = 7000

func _ready():
	set_physics_process(true)
	closestPlanet = get_closest_planet()
	$AnimationPlayer.current_animation = "Idle"
	$AnimationPlayer.play()
	
func _physics_process(delta):
	
	var nextPlanet = get_closest_planet()
	
	if(nextPlanet != closestPlanet && nextPlanet.is_in_gravity_field(global_position)):
		closestPlanet = nextPlanet
		
	applyMovement(delta)
	applyGravity(delta)
	applyJump(delta)
	
	var playerRot = get_player_rotation()
	
	velocity = Vector2(speed.x * delta, speed.y * delta)
	velocity = velocity.rotated(playerRot)
	
	move_and_slide(velocity)
	set_rotation(playerRot)
	
func applyMovement(delta):
	#Moving options
	if Input.is_action_pressed("ui_left"):
		direction = -1
		speed.x = MAX_SPEED * direction
	elif Input.is_action_pressed("ui_right"):
		direction = 1
		speed.x = MAX_SPEED * direction
	elif (abs(speed.x) > 0 && abs(speed.x)<20):
		speed.x = 0
	elif(abs(speed.x) > 0):
		speed.x += MAX_SPEED * delta * direction * -1
		
	speed.x = clamp(speed.x, -MAX_SPEED, MAX_SPEED)
	
func applyGravity(delta):
	if(closestPlanet.is_in_gravity_field(global_position)):
		speed.y += closestPlanet.GRAVITY
		
func applyJump(delta):
	if Input.is_action_pressed("ui_up"):
		speed.y = -JUMP_FORCE
		$AnimationPlayer.current_animation = "Jump"
	else:
		speed.y += JUMP_FORCE * delta
		
	speed.y = clamp(speed.y, -JUMP_FORCE, JUMP_FORCE) 
	
func get_player_rotation():
	var downVector = Vector2(0,1)
	if(closestPlanet):
		return downVector.angle_to(get_gravity_vector(closestPlanet))
	else:
		return rotation
		
func get_gravity_vector(planet):
	return (planet.gravityCenter.global_position - global_position).normalized()
	
func get_closest_planet():
	var distance = -1
	var foundPlanet = null
	
	for planet in get_tree().get_nodes_in_group("Planet"):
		if(planet.gravityCenter):
			if(distance < 0):
				foundPlanet = planet
				distance = planet.gravityCenter.global_position.distance_to(global_position)
			elif(distance > planet.gravityCenter.global_position.distance_to(global_position)):
				foundPlanet = planet
				distance = planet.gravityCenter.global_position.distance_to(global_position)
				
	return foundPlanet

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Jump":
		$AnimationPlayer.current_animation = "Idle"