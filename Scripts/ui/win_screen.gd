extends Control

func _on_back_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_menus/start_main_menu.tscn")
