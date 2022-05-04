extends Control

signal download(version)
signal cancel()

onready var version_btn = $Control/VBoxContainer/ContentMargin/VBoxContainer/VersionContainer/VersionBtn
onready var download_btn = $Control/VBoxContainer/ContentMargin/VBoxContainer/HBoxContainer5/DownloadBtn
onready var cancel_btn = $Control/VBoxContainer/ContentMargin/VBoxContainer/HBoxContainer5/CancelBtn
onready var download_label = $Control/VBoxContainer/ContentMargin/VBoxContainer/DownloadContainer/DownloadLabel
onready var download_bar = $Control/VBoxContainer/ContentMargin/VBoxContainer/DownloadContainer/ProgressBar

var alpha: bool = true
var beta: bool = true
var stable: bool = true

func _ready() -> void:
	fill_in_versions() 
	$Control/VBoxContainer/ContentMargin/VBoxContainer/TypeContainer.show()
	$Control/VBoxContainer/ContentMargin/VBoxContainer/VersionContainer.show()
	$Control/VBoxContainer/ContentMargin/VBoxContainer/DownloadContainer.hide()
	download_btn.show()
	cancel_btn.hide()
	download_bar.value = 0

func update_progress(val: float) -> void:
	download_bar.value = val
	
func fill_in_versions() -> void:
	for version in Globals.available_versions:
		# Skip the version we don't want to see
		if version["type"] == Globals.TYPE.ALPHA && not alpha: continue
		if version["type"] == Globals.TYPE.BETA && not beta: continue
		if version["type"] == Globals.TYPE.STABLE && not stable: continue
		
		version_btn.add_item(version["version"])
	
func erase_options() -> void:
	version_btn.clear()

func _on_Alpha_toggled(button_pressed: bool) -> void:
	alpha = button_pressed
	erase_options()
	fill_in_versions()

func _on_Beta_toggled(button_pressed: bool) -> void:
	beta = button_pressed
	erase_options()
	fill_in_versions()

func _on_Stable_toggled(button_pressed: bool) -> void:
	stable = button_pressed
	erase_options()
	fill_in_versions()

func _on_VersionBtn_item_selected(index: int) -> void:
	download_btn.text = "DOWNLOAD v%s" % version_btn.get_item_text(index)

func _on_DownloadBtn_pressed() -> void:
	var version = version_btn.get_item_text(version_btn.selected)
	emit_signal("download", version)
	download_label.text = "Downloading Godot %s" % version
	$Control/VBoxContainer/ContentMargin/VBoxContainer/TypeContainer.hide()
	$Control/VBoxContainer/ContentMargin/VBoxContainer/VersionContainer.hide()
	$Control/VBoxContainer/ContentMargin/VBoxContainer/DownloadContainer.show()
	download_btn.hide()
	cancel_btn.show()

func _on_CloseBtn_pressed() -> void:
	queue_free()

func _on_CancelBtn_pressed() -> void:
	emit_signal("cancel")
