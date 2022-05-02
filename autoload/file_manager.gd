extends Node

static func look_for_godot_in_dir(dir_path: String) -> Array:
	var res = []
	var dir = Directory.new()
	
	var godot_regex = RegEx.new()
	godot_regex.compile("(Godot_.*)")
	
	var version_regex = RegEx.new()
	version_regex.compile("((?:[0-9]\\.){1,2}[0-9])")
	
	var type_regex = RegEx.new()
	type_regex.compile("(?<=-)(.*?)(?=_)")
	
	if dir.open(dir_path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				# Check if godot
				var result = godot_regex.search(file_name)
				if result:
					print(result.get_string())
					var version_res = version_regex.search(file_name)
					if version_res:
						var type = ""
						print(version_res.get_string())
						var type_res = type_regex.search(file_name)
						if type_res:
							print(type_res.get_string())
							type = type_res.get_string()
						var version = {
							"path":dir_path.plus_file(file_name),
							"version": version_res.get_string(),
							"type": type
						}
						res.append(version)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
	return res
