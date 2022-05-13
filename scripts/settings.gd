extends ScrollContainer

signal finish()

onready var dir_path = $ContentMargin/VBoxContainer/GodotInstalls/HBoxContainer/DirPath

func _ready() -> void:
	# TODO: handle multiple paths
	dir_path.text = Globals.install_path

func _on_Startup_toggled(button_pressed: bool) -> void:
	Globals.launch_startup = button_pressed

func _on_AutoUpdate_toggled(button_pressed: bool) -> void:
	Globals.check_update_auto = button_pressed

func _on_DesktopShortcut_toggled(button_pressed: bool) -> void:
	pass

func _on_AutoDeleteInstall_toggled(button_pressed: bool) -> void:
	Globals.auto_delete_install_file = button_pressed

func _on_FinishBtn_pressed() -> void:
	UserSettings.apply_settings(UserSettings.load_settings())
	emit_signal("finish")

func _on_CancelBtn_pressed() -> void:
	UserSettings.grab_settings()
	UserSettings.save_settings()
	emit_signal("finish")
