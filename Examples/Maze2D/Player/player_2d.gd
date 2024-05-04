class_name Player2D extends CharacterBody2D

@export var move_speed: float = 100.0


func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	if direction:
		velocity = direction * move_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, move_speed)

	move_and_slide()
