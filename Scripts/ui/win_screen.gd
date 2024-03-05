extends Control

var fade = SFade.new()

func _on_try_again_button_pressed():
	fade.fade_out_in(get_tree().current_scene, load("res://Scenes/main.tscn"), 2, 0)
	#get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_go_to_the_menu_button_pressed():
	fade.fade_out_in(get_tree().current_scene,
	load("res://Scenes/ui_menus/start_main_menu.tscn"), 1, 0.25)
	#get_tree().change_scene_to_file("res://Scenes/ui_menus/start_main_menu.tscn")
