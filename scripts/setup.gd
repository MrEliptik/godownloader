extends Control

signal finish()

var desktop_shortcut: bool = true

onready var dirPath = $Control/VBoxContainer/ContentMargin/VBoxContainer/HBoxContainer/DirPath
onready var finishBtn = $Control/VBoxContainer/ContentMargin/VBoxContainer/HBoxContainer5/FinishBtn
onready var executablesFound = $Control/VBoxContainer/ContentMargin/VBoxContainer/ExecutablesFound

func _ready() -> void:
	finishBtn.disabled = true
	executablesFound.modulate.a = 0

func _on_BrowseBtn_pressed() -> void:
	$Control/FileDialog.show()

func _on_FinishBtn_pressed() -> void:
	emit_signal("finish")
	call_deferred("queue_free")

func _on_Startup_pressed() -> void:
	Globals.launch_startup

func _on_FileDialog_dir_selected(dir: String) -> void:
	dirPath.text = dir
#	Globals.godot_dirs.append(dir)
	finishBtn.disabled = false
	
	var res = FileManager.look_for_godot_in_dir(dir)
	executablesFound.text = "Found %s Godot executables" % res.size()
	executablesFound.modulate.a = 1.0
	
	for version in res:
		Globals.godot_versions.append(version)

func _on_Startup_toggled(button_pressed):
	Globals.launch_startup = button_pressed

func _on_CheckUpdateAuto_toggled(button_pressed):
	Globals.check_update_auto = button_pressed

func _on_DesktopShortcut_toggled(button_pressed):
	desktop_shortcut = button_pressed
