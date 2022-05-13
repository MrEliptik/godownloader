extends ScrollContainer

export var card_scene: PackedScene = preload("res://scenes/card.tscn")

onready var latest_version = $ContentMargin/VBoxContainer/LatestVersion
onready var installed = $ContentMargin/VBoxContainer/Installed

func _ready() -> void:
	display_installed()
	
func display_installed() -> void:
	for version in Globals.godot_versions:
		var instance = card_scene.instance()
		instance.path = version["path"]
		instance.version = version["version"]
		instance.type = Globals.TYPE_TO_STRING[version["type"]]
		instance.installed = true
		installed.add_child(instance)

func check_new_version_available() -> String:
	var latest_version = ""
	var latest_installed_version = ""
	
	for version in Globals.available_versions:
		if version["type"] != Globals.TYPE.STABLE: continue
		latest_version = get_higher_version(version["version"], latest_version)
			
#	print(latest_version)
	
	for version in Globals.godot_versions:
		if version["type"] != Globals.TYPE.STABLE: continue
		latest_installed_version = get_higher_version(version["version"], latest_installed_version)

	print(latest_installed_version)
	
	var new_version = get_higher_version(latest_version, latest_installed_version)
	if new_version != latest_installed_version:
		print("new_version: ", new_version)
	
	return new_version

func get_higher_version(vA, vB) -> String:
	var higher_version: String = ""
	
	# Get only the numbers in array form
	var splitA = vA.split(".")
	var splitB = vB.split(".")
	
	# initiliaze to one of the split
	# if they the versions are the same, we can return that
	# otherwise, it'll be overwritten
	var higher_version_arr = splitA
	
	# Make sure version are the same length by adding
	# zeros to the end
	while (splitA.size() < splitB.size()): 
		splitA.append("0")
	while (splitB.size() < splitA.size()):
		splitB.append("0")
	
	# Start comparing
	for i in range(splitA.size()):
		
		# Same number, we can continue
		if int(splitA[i]) == int(splitB[i]): continue
		
		# A has bigger number, we don't need to continue
		# the rest doesn't matter
		elif int(splitA[i]) > int(splitB[i]):
			higher_version_arr = splitA
			break
		# B has bigger number, we don't need to continue
		# the rest doesn't matter
		else:
			higher_version_arr = splitB
			break
	
	# Turn the split into a semantic version string again
	for i in range(higher_version_arr.size()):
		if i == (higher_version_arr.size()-1):
			higher_version += str(higher_version_arr[i])
		else:
			higher_version += str(higher_version_arr[i]) + "."
	
	return higher_version

func on_versions_updated() -> void:
	var new_version = check_new_version_available()
	if not new_version: return
	$ContentMargin/VBoxContainer/LatestVersion/Card.version = new_version
	$ContentMargin/VBoxContainer/LatestVersion/Card.path = ""
	$ContentMargin/VBoxContainer/LatestVersion.show()

func _on_Setup_finish() -> void:
	display_installed()
	
	Globals.setup_complete = true
	UserSettings.grab_settings()
	UserSettings.save_settings()
	
	check_new_version_available()
