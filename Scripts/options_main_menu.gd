extends Control

@export var start_main_menu: PackedScene
@export var sounds: Resource

@onready var sounds_volume_label: Label = $SoundsVolumeLabel
@onready var music_volume_label: Label = $MusicVolumeLabel

@onready var sounds_volume_hslider: HSlider = $SoundsVolumeHSlider
@onready var music_volume_hslider: HSlider = $MusicVolumeHSlider

@onready var play_sound_button: Button = $PlaySoundButton

var fade = SFade.new()

func _ready():
	sounds_volume_label.text = "Volume: " + str(
		round((sounds_volume_hslider.value))) + " / " + str(
		round((sounds_volume_hslider.max_value)))
	music_volume_label.text = "Volume: " + str(
		round((music_volume_hslider.value))) + " / " + str(
		round((music_volume_hslider.max_value)))

func _on_sounds_volume_h_slider_value_changed(value):
	sounds_volume_label.text = "Volume: " + str(round((value))) + " / " + str(
		round((sounds_volume_hslider.max_value)))

func _on_music_volume_h_slider_value_changed(value):
	music_volume_label.text = "Volume: " + str(round((value))) + " / " + str(
		round((music_volume_hslider.max_value)))


func _on_back_to_main_menu_button_pressed():
	fade.fade_out_in(get_tree().current_scene,
	load("res://Scenes/ui_menus/start_main_menu.tscn"), 0.25, 0.25)
	#get_tree().change_scene_to_file("res://Scenes/ui_menus/start_main_menu.tscn")

func _on_play_a_sound_button_pressed():
	
	pass
