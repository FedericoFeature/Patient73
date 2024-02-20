extends Control

func _on_try_again_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_go_to_the_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_menus/start_main_menu.tscn")
