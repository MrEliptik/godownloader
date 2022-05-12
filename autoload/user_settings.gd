extends Node

const SAVE_PATH = "user://config.cfg"

var config_file = ConfigFile.new()
var settings = {
	"godot": {
		"install_path": "",
		"setup_complete": false,
		"godot_versions": [],
	},
	"user": {
		"launch_startup": true,
		"check_update_auto": true,
		"auto_delete_install_file": true
	}
}

func _ready() -> void:
	## Create config file if not existing
	## otherwise, load values
	var file_check = File.new()
	if file_check.file_exists(SAVE_PATH):
		var values = load_settings()
		apply_settings(values)
	else:
		save_settings()

func save_settings():
	for section in settings.keys():
		for key in settings[section].keys():
			config_file.set_value(section, key, settings[section][key])
			
	config_file.save(SAVE_PATH)
	
func load_settings():
	var err = config_file.load(SAVE_PATH)
	if err != OK:
		print("Error loading the settings. Error code: %s" % err)
		return []
	
	var values = []
	for section in settings.keys():
		for key in settings[section].keys():
			var val = settings[section][key]
			values.append(config_file.get_value(section, key, val))
			settings[section][key] = config_file.get_value(section, key, val)
#			print("%s: %s" % [key, val])
	return settings
	
func grab_settings():
	settings["godot"]["install_path"] = Globals.install_path
	settings["godot"]["setup_complete"] = Globals.setup_complete
	settings["godot"]["godot_versions"] = Globals.godot_versions
	settings["user"]["launch_startup"] = Globals.launch_startup
	settings["user"]["check_update_auto"] = Globals.check_update_auto
	settings["user"]["auto_delete_install_file"] = Globals.auto_delete_install_file
	
func apply_settings(values: Dictionary):
	Globals.install_path = values["godot"]["install_path"]
	Globals.setup_complete = values["godot"]["setup_complete"]
	Globals.godot_versions = values["godot"]["godot_versions"]
	Globals.launch_startup = values["user"]["launch_startup"]
	Globals.check_update_auto = values["user"]["check_update_auto"]
	Globals.auto_delete_install_file = values["user"]["auto_delete_install_file"]
	
