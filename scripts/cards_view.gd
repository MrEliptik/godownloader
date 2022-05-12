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
		instance.type = version["type"]
		instance.installed = true
		installed.add_child(instance)

func check_new_version_available() -> void:
	var latest_version = ""
	var latest_version_arr = [0, 0, 0]
	for version in Globals.available_versions:
		if version["type"] != Globals.TYPE.STABLE: continue
		var split = version["version"].split(".")
		print(split)
		for i in range(split.size()):
			if int(split[i]) > latest_version_arr[i]:
				latest_version_arr[i] = int(split[i])

	
	for i in range(latest_version_arr.size()):
		if i == (latest_version_arr.size()-1):
			latest_version += str(latest_version_arr[i])
		else:
			latest_version += str(latest_version_arr[i]) + "."
			
	print(latest_version)
		
	
#	for version in Globals.godot_versions:
#		if version["type"] != Globals.TYPE.STABLE: continue
#		print(version["version"].split("."))

func on_versions_updated() -> void:
	pass
#	check_new_version_available()

func _on_Setup_finish() -> void:
	display_installed()
	
	Globals.setup_complete = true
	UserSettings.grab_settings()
	UserSettings.save_settings()
	
	check_new_version_available()
