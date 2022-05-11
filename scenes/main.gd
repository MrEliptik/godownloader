extends Control

export var setup_scene = preload("res://scenes/setup.tscn")
export var network = preload("res://autoload/network.tscn")
export var download_popup_scene = preload("res://scenes/download_popup.tscn")

var download_popup = null

onready var net_instance = network.instance()
onready var popup_cintainer = $PopupContainer
onready var notifications = $Notifications

func _ready() -> void:
	add_child(net_instance)
	net_instance.get_available_versions()
	net_instance.connect("download_progress", self, "on_download_progress")
	net_instance.connect("download_finished", self, "on_download_finished")
	net_instance.connect("versions_updated", $VBoxContainer/View/CardView, "on_versions_updated")
	
	if Globals.setup_complete:
		pass
	else:
		var instance = setup_scene.instance()
		popup_cintainer.add_child(instance)
		instance.connect("finish", $VBoxContainer/View/CardView, "_on_Setup_finish")
		
		
	notifications.queue_notification("Test blabla bla, long test, bla bla bla")

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
		notifications.queue_notification("Download finished! Unzipping..")
		# Unzip to install dir
		FileManager.unzip_to(path, Globals.install_path)
		
		notifications.queue_notification("Successfuly unzipped: %s" % path)
		# Remove download
		FileManager.delete_file(path)
	else:
		notifications.queue_notification("Download stopped. Deleting file..")
		# Remove download
		FileManager.delete_file(path)
	
