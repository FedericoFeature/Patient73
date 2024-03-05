extends Control

var fade = SFade.new()

func _on_play_button_pressed():
	fade.fade_out_in(get_tree().current_scene,
	load("res://Scenes/ui_menus/gamemode_selection_main_menu.tscn"), 0.25, 0.25)
	#get_tree().change_scene_to_file("res://Scenes/ui_menus/gamemode_selection_main_menu.tscn")

func _on_settings_button_pressed():
	fade.fade_out_in(get_tree().current_scene,
	load("res://Scenes/ui_menus/options_main_menu.tscn"), 0.25, 0.25)
	#get_tree().change_scene_to_file("res://Scenes/ui_menus/options_main_menu.tscn")

func _on_quit_button_pressed():
	fade.fade_out_no_scene_change(get_tree().current_scene, 1.25)
	#get_tree().quit()

#func helwor():
	#print ("hello world")
