extends Control

@export_range(0, 1.5) var opacity_up_time = 0.2
@export_range(0, 1.5) var opacity_down_time = 0.3
@export_range(0, 255) var opacity_down = 110

@onready var mazephobia_button: Button = $MazephobiaButton
@onready var dypraxia_button: Button = $DypraxiaButton
@onready var hemiplagia_button: Button = $HemiplagiaButton

func _ready():
	if (Globals.gamemode != ""):
		Globals.gamemode = ""

func _on_mouse_entered(mode):
	match mode:
		"mazephobia":	tween_opacity_up(mazephobia_button, "mazephobia")
		"dypraxia":	tween_opacity_up(dypraxia_button, "dypraxia")
		"hemiplagia":	tween_opacity_up(hemiplagia_button, "hemiplagia")


func _on_mouse_exited(mode):
	match mode:
		"mazephobia":	tween_opacity_down(mazephobia_button, "mazephobia")
		"dypraxia":	tween_opacity_down(dypraxia_button, "dypraxia")
		"hemiplagia":	tween_opacity_down(hemiplagia_button, "hemiplagia")


func tween_opacity_up(button: Button, mode):
	var tween: Tween = create_tween()
	tween.tween_property(button, "modulate",
		Color(button.modulate.r, button.modulate.g, button.modulate.b, 1),
		opacity_up_time)

func tween_opacity_down(button: Button, mode):
	var tween: Tween = create_tween()
	tween.tween_property(button, "modulate",
		Color(button.modulate.r, button.modulate.g, button.modulate.b, (1.0 / 255) * opacity_down),
		opacity_down_time)

func _on_gamemode_option_clicked(mode):
	match mode:
		"mazephobia":	set_gamemode("mazephobia")
		"dypraxia":	set_gamemode("dypraxia")
		"hemiplagia":	set_gamemode("hemiplagia")

func set_gamemode(gamemode_value):
	Globals.gamemode = gamemode_value
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_back_to_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_menus/start_main_menu.tscn")
