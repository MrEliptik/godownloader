extends MarginContainer

signal add_version()
signal settings()

func _ready() -> void:
	pass 

func _on_AddBtn_pressed() -> void:
	emit_signal("add_version")

func _on_SettingsBtn_pressed() -> void:
	emit_signal("settings")
