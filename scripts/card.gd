tool
extends Control

export var installed: bool = false setget set_installed

func _ready() -> void:
	
	# Set values
	$ContentMargin/HBoxContainer/DownloadBtn.visible = !installed
	$ContentMargin/HBoxContainer/EraseBtn.visible = installed

func set_installed(val: bool) -> void:
	installed = val
	if has_node("ContentMargin/HBoxContainer/DownloadBtn"):
		$ContentMargin/HBoxContainer/DownloadBtn.visible = !installed
	if has_node("ContentMargin/HBoxContainer/EraseBtn"):
		$ContentMargin/HBoxContainer/EraseBtn.visible = installed
