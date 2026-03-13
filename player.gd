extends CharacterBody3D

@export var speed: float = 5.0
@onready var anim_tree: AnimationTree = $AnimationTree

# Change this if your BlendSpace2D node in the AnimationTree has a different name
const BLEND_PATH := "parameters/Movement/blend_position"

func _ready() -> void:
	anim_tree.active = true

func _physics_process(_delta: float) -> void:
	# Uses ui_left/ui_right/ui_up/ui_down (now includes WASD)
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Convert to 3D world direction (Up should move forward which is -Z)
	var world_dir := Vector3(input_dir.x, 0.0, -input_dir.y)
	if world_dir.length() > 0.0:
		world_dir = world_dir.normalized()

	velocity.x = world_dir.x * speed
	velocity.z = world_dir.z * speed
	move_and_slide()

	# Animation: convert velocity to LOCAL space so forward/back/left/right match aim direction
	var v := Vector3(velocity.x, 0.0, velocity.z)

	var blend := Vector2.ZERO
	if v.length() > 0.05:
		var local_v: Vector3 = global_transform.basis.inverse() * v
		blend = Vector2(local_v.x, local_v.z).normalized()

	anim_tree.set(BLEND_PATH, blend)
