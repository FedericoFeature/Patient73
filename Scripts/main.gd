extends Node2D

@export var wait_before_player_start_timer: float = 5

@onready var maze_camera: Camera2D = get_tree().get_first_node_in_group("maze_cam")
@onready var darkness_canvas_modulate: CanvasModulate = $CanvasModulate

var hud_enabled = true

var timer_node: Timer = null
var time_left: float = 0
var is_wait_timer_over: bool = false
var white_color: Color = Color(1, 1 ,1 , 1)
var black_color: Color = Color(0, 0, 0, 1)

signal on_darkness_is_set

#const maze = preload("res://Scenes/main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	maze_camera.make_current()
	handle_wait_timer_setup()

func _physics_process(delta):
	handle_wait_timer_process()
	

func on_fringe_changed():
	$CanvasLayer/spots_visited_column.text = "\n".join(Globals.letters_to_show)

func handle_wait_timer_setup():
	darkness_canvas_modulate.color = white_color
	timer_node = Timer.new()
	timer_node.name = "WaitBeforePlayerStartTimer"
	timer_node.wait_time = wait_before_player_start_timer
	timer_node.timeout.connect(_on_wait_before_player_start_timer_timeout)
	add_child(timer_node)
	timer_node.start()

func _on_wait_before_player_start_timer_timeout():
	is_wait_timer_over = true

func handle_wait_timer_process():
	if (is_wait_timer_over):
		darkness_canvas_modulate.color = lerp(
			darkness_canvas_modulate.color, black_color, 0.05)
		
		if(darkness_canvas_modulate.color.r < 0.035):
			darkness_canvas_modulate.color = black_color
			is_wait_timer_over = false
			timer_node.stop()
			on_darkness_is_set.emit()
