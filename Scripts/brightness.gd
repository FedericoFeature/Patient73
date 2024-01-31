extends CanvasModulate


func _on_tile_map_intro_finished():
	print("nah")
	await get_tree().create_timer(0.6).timeout #Wait
	#self.color = Color(0,0,0,1)
	
