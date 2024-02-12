class_name Player # For easier reference to player later on
extends CharacterBody2D


@export var movement_speed: float = 200

@onready var animation_tree: AnimationTree = $AnimationTree # To apply new animations
@onready var player_camera: Camera2D = $Camera2D
@onready var maze_camera: Camera2D = get_tree().get_first_node_in_group("maze_cam")
@onready var point_light_2d: PointLight2D = $PointLight2D

var active: bool = true # To deactivate the player when necessary
var direction: Vector2 = Vector2.ZERO

var is_point_light_set: bool = true

func _ready():
	deactivate()
	get_parent().on_darkness_is_set.connect(_on_darkness_is_set)

func _process(delta):
	if (active):
		if(Input.is_action_just_pressed("change_perspective")):
			switch_camera_on_input()

func _physics_process(delta):
	if (active):
		get_and_process_input()
		update_movement_animations()
		apply_movement()
		point_light_process()

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

func switch_camera_on_input():
	if (maze_camera.is_current()):
		player_camera.make_current()
	else:
		maze_camera.make_current()

func point_light_process():
	if (not is_point_light_set):
		point_light_2d.color = lerp(
			point_light_2d.color, Color(1, 1, 1, 1), 0.01)
		
		if(point_light_2d.color.r > 0.965):
			point_light_2d.color = Color(1, 1, 1, 1)
			is_point_light_set = true

func _on_darkness_is_set():
	activate()
	switch_camera_on_input()
	is_point_light_set = false
