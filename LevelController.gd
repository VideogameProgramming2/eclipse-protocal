extends Node3D

@onready var cam: Camera3D = $Camera3D
@onready var player: CharacterBody3D = $Player

func _physics_process(_delta: float) -> void:
	var mouse_pos := get_viewport().get_mouse_position()

	var ray_origin := cam.project_ray_origin(mouse_pos)
	var ray_end := ray_origin + cam.project_ray_normal(mouse_pos) * 2000.0

	var space_state := get_world_3d().direct_space_state

	var query := PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	query.exclude = [player.get_rid()] # ignore player collider
	query.collision_mask = 1

	var hit := space_state.intersect_ray(query)
	#print(hit) # debug testing

	if hit.size() > 0:
		var pos: Vector3 = hit.position
		var look_target := Vector3(pos.x, player.global_position.y, pos.z)
		player.look_at(look_target, Vector3.UP)
