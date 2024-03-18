class_name StringFunctions
extends Node

func scene_path_to_pascal_case(path: String) -> String :
	var _path_node_name = ""
	var slice_count = path.get_slice_count("/")
	var cut_path = path.get_slice("/", slice_count - 1)
	var cut_path_no_ending = cut_path.split(".")[0]
	var sliced_path = cut_path_no_ending.split("_")
	for word in sliced_path:
		var pascal_word = word[0].to_upper() + word.substr(1, -1)
		_path_node_name += pascal_word
	return _path_node_name
