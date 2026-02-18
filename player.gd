extends CharacterBody3D

@export var speed: float = 5.0

func _physics_process(delta: float) -> void:
	# Get input as a Vector2 (x = left/right, y = up/down)
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Convert to 3D movement on X/Z plane
	var dir: Vector3 = Vector3(input_dir.x, 0.0, input_dir.y).normalized()

	# Set CharacterBody3D's built-in velocity
	velocity.x = dir.x * speed
	velocity.z = dir.z * speed

	move_and_slide()
