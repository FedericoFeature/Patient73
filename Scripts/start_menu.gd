extends Control

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_menus/gamemode_selection_main_menu.tscn")

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_menus/options_main_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
