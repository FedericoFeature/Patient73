class_name SFade
extends Node

var fade_out_color_default = Color(0, 0, 0, 1)
var fade_in_color_default = Color(0, 0, 0, 1)

var root_parent: Node
var fade_out_scene: Node
var fade_in_scene: Node
var fade_in_scene_resource: Resource
var fade_out_time: float
var fade_in_time: float
var fade_out_color: Color
var fade_in_color: Color
var fade_out_color_rect: ColorRect
var fade_out_canvas_layer: CanvasLayer
var fade_in_color_rect: ColorRect
var fade_in_canvas_layer: CanvasLayer

func fade_out_in(_from_scene: Node, _to_scene_resource: Resource,
_fade_out_time: float = 1, _fade_in_time: float = 1,
_from_color: Color = fade_out_color_default, _to_color: Color = fade_in_color_default):
	
	fade_out_scene = _from_scene
	fade_in_scene_resource = _to_scene_resource
	fade_out_time = _fade_out_time
	fade_in_time = _fade_in_time
	fade_out_color = _from_color
	fade_in_color = _to_color
	root_parent = fade_out_scene.get_tree().root
	fade_out_color_rect = ColorRect.new()
	fade_out_canvas_layer = CanvasLayer.new()
	fade_out_scene.add_child(fade_out_canvas_layer)
	fade_out_canvas_layer.add_child(fade_out_color_rect)
	fade_out_color_rect.set_position(Vector2.ZERO)
	fade_out_color_rect.size = fade_out_scene.get_viewport().content_scale_size
	fade_out_color_rect.color = fade_out_color
	fade_out_color_rect.color.a = 0
	
	var fade_out_tween: Tween = fade_out_scene.create_tween()
	fade_out_tween.finished.connect(_fade_out_in_tween_out_finished)
	fade_out_tween.tween_property(fade_out_color_rect, "color",
		Color(fade_out_color_rect.color.r, fade_out_color_rect.color.g,
		fade_out_color_rect.color.b, 1), fade_out_time)

func _fade_out_in_tween_out_finished():	
	
	fade_out_scene.queue_free()
	fade_in_scene = fade_in_scene_resource.instantiate()
	root_parent.add_child(fade_in_scene)
	fade_in_color_rect = ColorRect.new()
	fade_in_canvas_layer = CanvasLayer.new()
	fade_in_scene.add_child(fade_in_canvas_layer)
	fade_in_canvas_layer.add_child(fade_in_color_rect)
	fade_in_color_rect.set_position(Vector2.ZERO)
	fade_in_color_rect.size = fade_in_scene.get_viewport().content_scale_size
	fade_in_color_rect.color = fade_in_color
	
	var fade_in_tween: Tween = fade_in_scene.create_tween()
	fade_in_tween.finished.connect(_fade_out_in_tween_in_finished)	
	fade_in_tween.tween_property(fade_in_color_rect, "color",
		Color(fade_in_color_rect.color.r, fade_in_color_rect.color.g,
		fade_in_color_rect.color.b, 0), fade_in_time)

func _fade_out_in_tween_in_finished():
	fade_in_scene.queue_free()
	root_parent.get_tree().change_scene_to_file(fade_in_scene_resource.resource_path)
