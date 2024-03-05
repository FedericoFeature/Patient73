extends Control

var fade = SFade.new()

func _on_confirm_button_pressed():
	fade.fade_out_in(get_tree().current_scene,
	load("res://Scenes/ui_menus/start_main_menu.tscn"), 2, 0.25)
	#get_tree().change_scene_to_file("res://Scenes/ui_menus/start_main_menu.tscn")
