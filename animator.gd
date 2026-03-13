extends Node

@export var idle_anim_name: String = "mixamo_com" # change later when renamed
@onready var anim_player: AnimationPlayer = $"../AnimationPlayer"

func _ready() -> void:
	# Force looping and play idle
	var anim := anim_player.get_animation(idle_anim_name)
	if anim:
		anim.loop_mode = Animation.LOOP_LINEAR
	anim_player.play(idle_anim_name)
