extends Control

@export var group: ButtonGroup

@onready var mazephobia_button: Button = $MazephobiaButton
@onready var dypraxia_button: Button = $DypraxiaButton
@onready var hemiplagia_button: Button = $HemiplagiaButton
@onready var start_game_button: Button = $StartGameButton

var selected_option: String = ""

func _ready():
	if (Globals.gamemode != ""):
		Globals.gamemode = ""

func _on_gamemode_option_clicked():
	match group.get_pressed_button():
		mazephobia_button:
			selected_option = "mazephobia"
			start_button_active(true)
		dypraxia_button:
			selected_option = "dypraxia"
			start_button_active(true)
		hemiplagia_button:
			selected_option = "hemiplagia"
			start_button_active(true)
		_:
			selected_option = ""
			start_button_active(false)

func start_button_active(value: bool):
	start_game_button.disabled = not value

func _on_start_game_button_pressed():
	Globals.gamemode = selected_option
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_back_to_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_menus/start_main_menu.tscn")
