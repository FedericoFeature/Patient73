extends Control

@export var start_main_menu: PackedScene

@onready var sounds_check_box: CheckBox = $SoundsCheckBox
@onready var music_check_box: CheckBox = $MusicCheckBox

@onready var sounds_label: Label = $SoundsLabel
@onready var music_label: Label = $MusicLabel

@onready var sounds_volume_label: Label = $SoundsVolumeLabel
@onready var music_volume_label: Label = $MusicVolumeLabel

@onready var sounds_volume_hslider: HSlider = $SoundsVolumeHSlider
@onready var music_volume_hslider: HSlider = $MusicVolumeHSlider

func _ready():
	sounds_volume_label.text = "Volume: " + str(
		round((sounds_volume_hslider.value))) + " / " + str(
		round((sounds_volume_hslider.max_value)))
	music_volume_label.text = "Volume: " + str(
		round((music_volume_hslider.value))) + " / " + str(
		round((music_volume_hslider.max_value)))
	slider_access_handler()

func _on_sounds_check_box_toggled(button_pressed):
	var on_off_text = "ON" if button_pressed else "OFF"	
	sounds_label.text = "Sound Effects: " + str(on_off_text)
	slider_access_handler()

func _on_music_check_box_toggled(button_pressed):
	var on_off_text = "ON" if button_pressed else "OFF"
	music_label.text = "Music: " + str(on_off_text)
	slider_access_handler()

func _on_sounds_volume_h_slider_value_changed(value):
	sounds_volume_label.text = "Volume: " + str(round((value))) + " / " + str(
		round((sounds_volume_hslider.max_value)))

func _on_music_volume_h_slider_value_changed(value):
	music_volume_label.text = "Volume: " + str(round((value))) + " / " + str(
		round((music_volume_hslider.max_value)))


func _on_back_to_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_menus/start_main_menu.tscn")

func slider_access_handler():
	sounds_volume_hslider.editable = true if sounds_check_box.button_pressed else false
	sounds_volume_hslider.scrollable = true if sounds_check_box.button_pressed else false
	music_volume_hslider.editable = true if music_check_box.button_pressed else false
	music_volume_hslider.scrollable = true if music_check_box.button_pressed else false
	if (not sounds_check_box.button_pressed):
		_on_sounds_volume_h_slider_value_changed(0)
		sounds_volume_hslider.value = 0
	if (not music_check_box.button_pressed):
		_on_music_volume_h_slider_value_changed(0)
		music_volume_hslider.value = 0		
	
