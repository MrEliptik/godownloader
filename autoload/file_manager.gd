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

static func unzip_to(path: String, to: String) -> void:
	# Convert relative path to absolute
	var abs_path = get_abs_path(path)
	# Convert path to "windows" path, necessary for "del"
	abs_path = abs_path.replacen("/", "\\")
	
	to = to.replacen("/", "\\")
	
	print("\"%s\""%to)

	var output = []
#	Expand-Archive -LiteralPath .\Godot_v3.4.3-stable_win64.exe.zip -DestinationPath "C:\Users\Victor\Downloads\Godot_v3.4.3" -Force
	if OS.execute("powershell.exe", 
		["-Command", "Expand-Archive", "-LiteralPath", abs_path, "-DestinationPath", "\'%s\'"%to, "-Force"], 
		true, output, true) != OK:
		print("Unzipping %s failed" % abs_path)
		print(output)

static func delete_file(path: String) -> void:
	# Convert relative path to absolute
	var abs_path = get_abs_path(path)
	# Convert path to "windows" path, necessary for "del"
	abs_path = abs_path.replacen("/", "\\")
	var output = []
	if OS.execute("del", [abs_path], true, output, true) != OK:
		print("Deleting %s failed" % abs_path)
		print(output)

# Converts relative path to absolute
static func get_abs_path(path: String) -> String:
	var file = File.new()
	file.open(path, File.READ)
	var abs_path = file.get_path_absolute()
	file.close()
	return abs_path
