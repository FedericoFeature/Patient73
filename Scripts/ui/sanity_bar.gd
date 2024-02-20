class_name SanityBar
extends Control

@export_range(0.0, 5.0) var increase_sanity_bar_interval_seconds = 1.0
@export_range(0, 100) var bad_brain_percent = 30
@export_range(0, 100) var very_bad_brain_percent = 65

@onready var v_slider: VSlider = $VSlider
@onready var brain_texture_rect: TextureRect = $TextureRect

var good_brain_texture: CompressedTexture2D = preload("res://sprites/sanity_bar/brain_good.png")
var bad_brain_texture: CompressedTexture2D = preload("res://sprites/sanity_bar/brain_bad.png")
var very_bad_brain_texture: CompressedTexture2D = preload("res://sprites/sanity_bar/brain_very_bad.png")
var dead_brain_texture: CompressedTexture2D = preload("res://sprites/sanity_bar/brain_dead.png")

var timer_node: Timer = null
var is_sanity_bar_full: bool = false

func _ready():
	start_bar()

func handle_wait_timer_setup():
	timer_node = Timer.new()
	timer_node.name = "TimeIntervalToIncreaseSanityBar"
	timer_node.wait_time = increase_sanity_bar_interval_seconds
	timer_node.timeout.connect(_on_interval_to_increase_sanity_bar_timeout)
	timer_node.one_shot = false
	add_child(timer_node)
	timer_node.start()

func _on_interval_to_increase_sanity_bar_timeout():
	if (not is_sanity_bar_full and get_value() < get_max_value()):
		increase_value(v_slider.step)
		update_brain_texture()
	elif (get_value() >= get_max_value()):
		update_brain_texture()
		is_sanity_bar_full = true
		timer_node.stop()

func update_brain_texture():
	var sanity_bar_fill_percentage = 100 / get_max_value() * get_value()
	if (sanity_bar_fill_percentage >= get_max_value()):
		set_texture(dead_brain_texture)
	elif (sanity_bar_fill_percentage >= very_bad_brain_percent):
		set_texture(very_bad_brain_texture)
	elif (sanity_bar_fill_percentage >= bad_brain_percent):
		set_texture(bad_brain_texture)
	elif (sanity_bar_fill_percentage < bad_brain_percent):
		set_texture(good_brain_texture)

func set_texture(texture):
	brain_texture_rect.texture = texture

func increase_value(value):
	v_slider.value += abs(value)
	update_brain_texture()

func decrease_value(value):
	v_slider.value -= abs(value)
	update_brain_texture()

func set_value(value):
		v_slider.value = value

func get_value():
	return v_slider.value

func get_max_value():
	return v_slider.max_value

func reset_bar():
	if (timer_node):
		timer_node.queue_free()
		timer_node = null
	v_slider.value = 0
	brain_texture_rect.texture = good_brain_texture
	is_sanity_bar_full = false

func stop_bar():
	if (timer_node && not timer_node.is_stopped()):
			timer_node.stop()

func continue_bar():
	if (timer_node && timer_node.is_stopped()):
			timer_node.start()

func start_bar():
	if (not timer_node):
		handle_wait_timer_setup()
