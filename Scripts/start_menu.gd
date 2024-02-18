extends Control

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_menus/gamemode_selection_main_menu.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_menus/options_main_menu.tscn")
