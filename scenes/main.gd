extends Control

export var network = preload("res://autoload/network.tscn")
export var download_popup_scene = preload("res://scenes/download_popup.tscn")

var download_popup = null

onready var net_instance = network.instance()

func _ready() -> void:
	add_child(net_instance)
	net_instance.get_available_versions()
	net_instance.connect("download_progress", self, "on_download_progress")
	net_instance.connect("download_finished", self, "on_download_finished")

func _on_TopBar_add_version() -> void:
	var instance = download_popup_scene.instance()
	add_child(instance)
	instance.connect("download", self, "on_download_popup_download")
	instance.connect("cancel", self, "on_download_popup_cancel")
	download_popup = instance

func _on_TopBar_settings() -> void:
	pass # Replace with function body.
	
func on_download_popup_download(version: String) -> void:
	net_instance.download_version(version)

func on_download_popup_cancel() -> void:
	net_instance.cancel_download()

func on_download_progress(progress: int) -> void:
	download_popup.update_progress(progress)
	
func on_download_finished(complete: bool, path:String) -> void:
	download_popup.queue_free()
	if complete:
		pass
		# Unzip to install dir
		
		# Remove download
#		FileManager.delete_file(path)
	else:
		# Remove download
		FileManager.delete_file(path)
	
