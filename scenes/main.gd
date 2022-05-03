extends Control

export var network = preload("res://autoload/network.tscn")
export var download_popup_scene = preload("res://scenes/download_popup.tscn")

onready var net_instance = network.instance()

func _ready() -> void:
	add_child(net_instance)
	net_instance.get_available_versions()

func _on_TopBar_add_version() -> void:
	var instance = download_popup_scene.instance()
	add_child(instance)
	instance.connect("download", self, "on_download_popup_download")

func _on_TopBar_settings() -> void:
	pass # Replace with function body.
	
func on_download_popup_download(version: String) -> void:
	net_instance.download_version(version)
