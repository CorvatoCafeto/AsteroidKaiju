extends KinematicBody2D

class_name Astronaut

var closestPlanet

var direction = 1

var can_move = true

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
	
	if (Globals.escape == true):
		self.visible = false	
	
	if Globals.death == false and Globals.escape != true:
		applyMovement(delta)
		applyGravity(delta)
		applyJump(delta)
		checkHit()
		
		var playerRot = get_player_rotation()
		
		velocity = Vector2(speed.x * delta, speed.y * delta)
		velocity = velocity.rotated(playerRot)
		
		#move_and_slide(velocity)
		move_and_slide_with_snap(velocity, Vector2(0, -1), Vector2(0, 32)) 
		set_rotation(playerRot)

func checkHit():
	if Globals.hit == true:
		$AnimationPlayer.current_animation = "Hit"
		Globals.hit = false
	if Globals.astronaut_health <= 0:
		Globals.death = true
		$AnimationPlayer.current_animation = "Death"
		$AnimationPlayer.play()
		
	
func applyMovement(delta):
	#Moving options
	if Input.is_action_pressed("ui_left"):
		direction = -1
		speed.x = MAX_SPEED * direction
		if can_move:
			$AnimationPlayer.current_animation = "Move"
			can_move = false
	elif Input.is_action_pressed("ui_right"):
		direction = 1
		speed.x = MAX_SPEED * direction
		if can_move:
			$AnimationPlayer.current_animation = "Move"
			can_move = false
	elif (abs(speed.x) > 0 && abs(speed.x)<20):
		speed.x = 0
		$AnimationPlayer.current_animation = "Idle"
	elif(abs(speed.x) > 0):
		speed.x += MAX_SPEED * delta * direction * -1
		
	if Input.is_action_just_released("ui_left"):
		can_move = true
	if Input.is_action_just_released("ui_right"):
		can_move = true
	
	if $RechargeRaycast.is_colliding():
		Globals.jetpack_fuel = 100
	
	speed.x = clamp(speed.x, -MAX_SPEED, MAX_SPEED)
	
func applyGravity(delta):
	if(closestPlanet.is_in_gravity_field(global_position)):
		speed.y += closestPlanet.GRAVITY
		
func applyJump(delta):
	if Input.is_action_pressed("ui_up"):
		if(Globals.jetpack_fuel >= Globals.jetpack_step):
			speed.y = -JUMP_FORCE
			$AnimationPlayer.current_animation = "Jump"
			Globals.jetpack_fuel -= Globals.jetpack_step
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
	if anim_name == "Jump" or anim_name == "Hit":
		$AnimationPlayer.current_animation = "Idle"