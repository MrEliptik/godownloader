extends Control

signal finish()

func _ready() -> void:
	pass 

func _on_BrowseBtn_pressed() -> void:
	$Control/FileDialog.show()

func _on_FinishBtn_pressed() -> void:
	emit_signal("finish")
	call_deferred("queue_free")
