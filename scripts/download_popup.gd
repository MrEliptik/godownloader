extends Control

signal download(version)

onready var version_btn = $Control/VBoxContainer/ContentMargin/VBoxContainer/VBoxContainer2/VersionBtn
onready var download_btn = $Control/VBoxContainer/ContentMargin/VBoxContainer/HBoxContainer5/DownloadBtn

var alpha: bool = true
var beta: bool = true
var stable: bool = true

func _ready() -> void:
	fill_in_versions() 

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
	emit_signal("download", version_btn.get_item_text(version_btn.selected))

func _on_CloseBtn_pressed() -> void:
	queue_free()
