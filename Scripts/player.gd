extends CharacterBody2D

class_name Player # For easier reference to player later on

@export var movement_speed = 200

@onready var animation_tree = $AnimationTree # To apply new animations

var active = true # To deactivate the player when necessary
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	if (active):
		get_and_process_input()
		update_movement_animations()
		apply_movement()

func get_and_process_input():
		var vertical_direction: float = Input.get_axis("move_up", "move_down")
		var horizontal_direction: float = Input.get_axis("move_left", "move_right")
		
#		We're normalizing the vector to keep diagonal speed consistent with non diagonal
		direction = Vector2(horizontal_direction, vertical_direction).normalized()

func update_movement_animations():
	if (direction == Vector2.ZERO):
		animation_tree.get("parameters/playback").travel("Idle")
	else:
		animation_tree.get("parameters/playback").travel("Move")
		animation_tree.set("parameters/Idle/blend_position", direction)
		animation_tree.set("parameters/Move/blend_position", direction)

func apply_movement():
		velocity = direction * movement_speed
		move_and_slide()

func deactivate():
	active = false

func activate():
	active = true
