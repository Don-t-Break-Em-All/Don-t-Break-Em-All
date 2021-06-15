extends "res://src/Actors/Actor.gd"

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x
	
func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
		
	anim_player.play("death")
	_velocity.x = 0;
	yield(anim_player, "animation_finished")
	get_node("CollisionShape2D").disabled = true
	queue_free()

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	if _velocity.x == 1:
		get_node("enemy").set_flip_h(false)
	elif _velocity.x == -1:
		get_node("enemy").set_flip_h(true)

