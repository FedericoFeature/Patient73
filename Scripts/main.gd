extends Node2D

var hud_enabled = true
#const maze = preload("res://Scenes/main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#ProjectSettings.set("display/window/size/viewport_width", 800)
	#ProjectSettings.set("display/window/size/viewport_height", 600)
	pass

func on_fringe_changed():
	$CanvasLayer/spots_visited_column.text = "\n".join(Globals.letters_to_show)
