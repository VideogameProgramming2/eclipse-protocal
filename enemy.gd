extends CharacterBody3D

@onready var nav = $NavigationAgent3D

const SPEED = 3.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var direction = next_location - current_location

# Hopeful fix when contact happens
	if direction.length() > 0.1:
		direction = direction.normalized()
		var new_velocity = direction * SPEED
		velocity = velocity.move_toward(new_velocity, 0.25)
		velocity.y = 0
	move_and_slide()
	
func target_position(target):
	nav.target_position = target
