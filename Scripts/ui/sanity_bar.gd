extends Control

@export_range(0.0, 5.0) var increase_sanity_bar_interval_seconds = 1.0
@export_range(0, 100) var bad_brain_percent = 30
@export_range(0, 100) var very_brain_percent = 65

@onready var v_slider: VSlider = $VSlider
@onready var brain_texture_rect: TextureRect = $TextureRect

var good_brain_texture: CompressedTexture2D = preload("res://sprites/sanity_bar/brain_good.png")
var bad_brain_texture: CompressedTexture2D = preload("res://sprites/sanity_bar/brain_bad.png")
var very_bad_brain_texture: CompressedTexture2D = preload("res://sprites/sanity_bar/brain_very_bad.png")
var dead_brain_texture: CompressedTexture2D = preload("res://sprites/sanity_bar/brain_dead.png")

var timer_node: Timer = null
var time_left: float = 0
var is_sanity_bar_full: bool = false

func _ready():
	start_sanity_bar()

func handle_wait_timer_setup():
	timer_node = Timer.new()
	timer_node.name = "TimeIntervalToIncreaseSanityBar"
	timer_node.wait_time = increase_sanity_bar_interval_seconds
	timer_node.timeout.connect(_on_interval_to_increase_sanity_bar_timeout)
	timer_node.one_shot = false
	add_child(timer_node)
	timer_node.start()

func _on_interval_to_increase_sanity_bar_timeout():
	if (not is_sanity_bar_full and v_slider.value < v_slider.max_value):
		v_slider.value += v_slider.step
		var sanity_bar_fill_percentage = 100 / v_slider.max_value * v_slider.value
		
		if (sanity_bar_fill_percentage >= very_brain_percent):
			brain_texture_rect.texture = very_bad_brain_texture
		elif (sanity_bar_fill_percentage >= bad_brain_percent):
			brain_texture_rect.texture = bad_brain_texture
		elif (sanity_bar_fill_percentage < bad_brain_percent):
			brain_texture_rect.texture = good_brain_texture
	elif (v_slider.value >= v_slider.max_value):
		brain_texture_rect.texture = dead_brain_texture
		is_sanity_bar_full = true
		timer_node.stop()

func reset_sanity_bar():
	if (timer_node):
		timer_node.queue_free()
		timer_node = null
	v_slider.value = 0
	brain_texture_rect.texture = good_brain_texture
	is_sanity_bar_full = false

func stop_sanity_bar():
	if (timer_node && not timer_node.is_stopped()):
			timer_node.stop()

func continue_sanity_bar():
	if (timer_node && timer_node.is_stopped()):
			timer_node.start()

func start_sanity_bar():
	if (not timer_node):
		handle_wait_timer_setup()
