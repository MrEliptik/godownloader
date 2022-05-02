tool
extends Control

export var installed: bool = false setget set_installed

var version: String = "x.x.x"
var path: String = "path/to/somewhere"
var type: String = ""

onready var version_label = $ContentMargin/HBoxContainer/VBoxContainer/Version
onready var path_label = $ContentMargin/HBoxContainer/VBoxContainer/Path

func _ready() -> void:
	version_label.text = version + " - " + type
	path_label.text = path
	# Set values
	$ContentMargin/HBoxContainer/DownloadBtn.visible = !installed
	$ContentMargin/HBoxContainer/EraseBtn.visible = installed
	$ContentMargin/HBoxContainer/LaunchBtn.visible = installed

func set_installed(val: bool) -> void:
	installed = val
	if has_node("ContentMargin/HBoxContainer/DownloadBtn"):
		$ContentMargin/HBoxContainer/DownloadBtn.visible = !installed
	if has_node("ContentMargin/HBoxContainer/EraseBtn"):
		$ContentMargin/HBoxContainer/EraseBtn.visible = installed
		
func launch(path: String) -> void:
	var output = []
	# -p to launch project manager
	# https://godotengine.org/qa/99353/opening-a-godot-game-from-another-wrong-project-lauches
	var pid = OS.execute(path, ["-p"], false, output)
	print(pid)
	print(output)

func _on_LaunchBtn_pressed() -> void:
	launch(path)
